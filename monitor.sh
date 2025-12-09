#!/bin/bash

# =============================================================================
# SCRIPT DE MONITOREO CONTINUO PARA SISTEMA CPS
# Opción D - Monitoreo Automático Continuo
# =============================================================================

set -euo pipefail

# Configuración
APP_NAME="CPS License Management"
APP_DIR="/var/www/system"
LOG_FILE="/var/log/cps-monitor.log"
PID_FILE="/var/run/cps-monitor.pid"
CONFIG_FILE="/etc/cps/monitor.conf"

# Umbrales de alerta
DISK_THRESHOLD=90
MEMORY_THRESHOLD=80
CPU_THRESHOLD=80
ERROR_THRESHOLD=10
RESPONSE_TIME_THRESHOLD=5

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Funciones auxiliares
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}" | tee -a "$LOG_FILE"
    send_alert "ERROR" "$1"
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}" | tee -a "$LOG_FILE"
    send_alert "WARNING" "$1"
}

info() {
    echo -e "${BLUE}[INFO] $1${NC}" | tee -a "$LOG_FILE"
}

send_alert() {
    local severity="$1"
    local message="$2"
    
    # Aquí se puede integrar con diferentes sistemas de alerta:
    # - Email (usando mailutils)
    # - Slack webhook
    # - Telegram bot
    # - Discord webhook
    # - PagerDuty
    # - etc.
    
    case "$severity" in
        ERROR)
            echo "$(date): ALERT - $message" >> "$LOG_FILE"
            # Implementar envío de alerta según necesidades
            ;;
        WARNING)
            echo "$(date): WARNING - $message" >> "$LOG_FILE"
            # Implementar envío de alerta según necesidades
            ;;
    esac
}

check_dependencies() {
    local missing_deps=()
    
    for cmd in curl mysql php nginx; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        error "Dependencias faltantes: ${missing_deps[*]}"
        return 1
    fi
    
    return 0
}

check_disk_space() {
    local usage=$(df "$APP_DIR" | awk 'NR==2 {print $5}' | sed 's/%//')
    local available=$(df -h "$APP_DIR" | awk 'NR==2 {print $4}')
    
    if [[ $usage -gt $DISK_THRESHOLD ]]; then
        error "Uso de disco alto: ${usage}% (disponible: $available)"
        return 1
    elif [[ $usage -gt $((DISK_THRESHOLD - 10)) ]]; then
        warning "Uso de disco approaching threshold: ${usage}% (disponible: $available)"
    fi
    
    return 0
}

check_memory_usage() {
    local memory_usage=$(free | grep Mem | awk '{printf("%.0f", $3/$2 * 100.0)}')
    
    if [[ $memory_usage -gt $MEMORY_THRESHOLD ]]; then
        error "Uso de memoria alto: ${memory_usage}%"
        return 1
    fi
    
    return 0
}

check_cpu_usage() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//')
    local cpu_int=${cpu_usage%.*}  # Convertir a entero
    
    if [[ $cpu_int -gt $CPU_THRESHOLD ]]; then
        error "Uso de CPU alto: ${cpu_int}%"
        return 1
    fi
    
    return 0
}

check_nginx_status() {
    if ! systemctl is-active --quiet nginx; then
        error "Nginx está caído, intentando reiniciar..."
        systemctl restart nginx
        sleep 5
        if systemctl is-active --quiet nginx; then
            warning "Nginx reiniciado exitosamente"
        else
            error "Fallo al reiniciar Nginx"
            return 1
        fi
    fi
    
    return 0
}

check_php_fpm_status() {
    local php_version="8.3"
    
    if ! systemctl is-active --quiet php${php_version}-fpm; then
        error "PHP-FPM está caído, intentando reiniciar..."
        systemctl restart php${php_version}-fpm
        sleep 5
        if systemctl is-active --quiet php${php_version}-fpm; then
            warning "PHP-FPM reiniciado exitosamente"
        else
            error "Fallo al reiniciar PHP-FPM"
            return 1
        fi
    fi
    
    return 0
}

check_database_connectivity() {
    # Verificar si MySQL está corriendo
    if ! systemctl is-active --quiet mysql && ! systemctl is-active --quiet mariadb; then
        error "Base de datos MySQL/MariaDB está caída"
        return 1
    fi
    
    # Verificar conectividad de la aplicación con la base de datos
    cd "$APP_DIR"
    if php artisan migrate:status &> /dev/null; then
        info "Conectividad de base de datos: OK"
    else
        error "Error de conectividad con base de datos"
        return 1
    fi
    
    return 0
}

check_laravel_errors() {
    local laravel_log="$APP_DIR/storage/logs/laravel.log"
    
    if [[ ! -f "$laravel_log" ]]; then
        warning "Archivo de log de Laravel no encontrado"
        return 1
    fi
    
    # Contar errores en las últimas 100 líneas
    local error_count=$(tail -n 100 "$laravel_log" 2>/dev/null | grep -c "ERROR\|CRITICAL\|Exception" || echo "0")
    
    if [[ $error_count -gt $ERROR_THRESHOLD ]]; then
        error "Alto número de errores en Laravel log: $error_count"
        # Mostrar últimos errores
        info "Últimos errores:"
        tail -n 10 "$laravel_log" | grep -E "ERROR|CRITICAL|Exception" | tail -n 3
        return 1
    elif [[ $error_count -gt $((ERROR_THRESHOLD / 2)) ]]; then
        warning "Número moderado de errores en Laravel log: $error_count"
    fi
    
    return 0
}

check_web_response() {
    local domain="${1:-cps.qhosting.net}"
    local response_time
    local http_code
    
    # Verificar respuesta HTTP
    response_time=$(curl -o /dev/null -s -w '%{time_total}' "https://$domain" 2>/dev/null || echo "999")
    http_code=$(curl -o /dev/null -s -w '%{http_code}' "https://$domain" 2>/dev/null || echo "000")
    
    if [[ "$http_code" != "200" ]]; then
        error "HTTP response code no válido: $http_code"
        return 1
    fi
    
    # Verificar tiempo de respuesta
    if (( $(echo "$response_time > $RESPONSE_TIME_THRESHOLD" | bc -l) )); then
        warning "Tiempo de respuesta alto: ${response_time}s (threshold: ${RESPONSE_TIME_THRESHOLD}s)"
    fi
    
    return 0
}

check_ssl_certificate() {
    local domain="${1:-cps.qhosting.net}"
    local expiry_date
    
    expiry_date=$(echo | openssl s_client -servername "$domain" -connect "$domain:443" 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notAfter | cut -d= -f2)
    
    if [[ -n "$expiry_date" ]]; then
        local expiry_timestamp=$(date -d "$expiry_date" +%s)
        local current_timestamp=$(date +%s)
        local days_until_expiry=$(( (expiry_timestamp - current_timestamp) / 86400 ))
        
        if [[ $days_until_expiry -lt 30 ]]; then
            warning "Certificado SSL expira en $days_until_expiry días"
        elif [[ $days_until_expiry -lt 7 ]]; then
            error "Certificado SSL expira en $days_until_expiry días - RENOVAR URGENTE"
            return 1
        fi
    fi
    
    return 0
}

check_laravel_queues() {
    cd "$APP_DIR"
    
    # Verificar si hay trabajos fallidos
    local failed_jobs=$(php artisan queue:failed 2>/dev/null | grep -c "Failed Job" || echo "0")
    
    if [[ $failed_jobs -gt 0 ]]; then
        warning "Hay $failed_jobs trabajos fallidos en la cola"
    fi
    
    # Verificar si el worker de cola está corriendo
    if ! pgrep -f "php artisan queue:work" > /dev/null; then
        warning "Queue worker no está corriendo"
    fi
    
    return 0
}

check_file_permissions() {
    local permission_errors=0
    
    # Verificar permisos de directorios críticos
    local critical_dirs=(
        "$APP_DIR/storage"
        "$APP_DIR/bootstrap/cache"
        "$APP_DIR/storage/logs"
        "$APP_DIR/storage/framework"
    )
    
    for dir in "${critical_dirs[@]}"; do
        if [[ ! -w "$dir" ]]; then
            error "Directorio sin permisos de escritura: $dir"
            ((permission_errors++))
        fi
    done
    
    if [[ $permission_errors -gt 0 ]]; then
        error "$permission_errors directorios con problemas de permisos"
        return 1
    fi
    
    return 0
}

run_performance_test() {
    local domain="${1:-cps.qhosting.net}"
    
    info "Ejecutando prueba de rendimiento básica..."
    
    # Verificar que la página principal carga correctamente
    local start_time=$(date +%s.%N)
    curl -s "https://$domain" > /dev/null
    local end_time=$(date +%s.%N)
    local load_time=$(echo "$end_time - $start_time" | bc)
    
    info "Tiempo de carga: ${load_time}s"
    
    # Verificar tiempo de respuesta de la API (si existe)
    if curl -s "https://$domain/api/health" > /dev/null 2>&1; then
        local api_start=$(date +%s.%N)
        curl -s "https://$domain/api/health" > /dev/null
        local api_end=$(date +%s.%N)
        local api_time=$(echo "$api_end - $api_start" | bc)
        info "Tiempo de respuesta API: ${api_time}s"
    fi
    
    return 0
}

generate_status_report() {
    local report_file="/var/log/cps-daily-report-$(date +%Y%m%d).txt"
    
    {
        echo "=========================================="
        echo "REPORTE DIARIO - CPS MONITOR"
        echo "Fecha: $(date)"
        echo "=========================================="
        echo ""
        
        echo "ESTADO DEL SISTEMA:"
        echo "-------------------"
        echo "Disco: $(df -h "$APP_DIR" | awk 'NR==2 {print $5 " usado, " $4 " disponible"}')"
        echo "Memoria: $(free -h | grep Mem | awk '{print $3 "/" $2 " usada"}')"
        echo "CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')"
        echo ""
        
        echo "SERVICIOS:"
        echo "----------"
        echo "Nginx: $(systemctl is-active nginx)"
        echo "PHP-FPM: $(systemctl is-active php8.3-fpm)"
        echo "MySQL: $(systemctl is-active mysql || systemctl is-active mariadb)"
        echo ""
        
        echo "LARAVEL:"
        echo "--------"
        echo "Tamaño de logs: $(du -sh "$APP_DIR/storage/logs" 2>/dev/null | cut -f1)"
        echo "Últimos errores: $(tail -n 5 "$APP_DIR/storage/logs/laravel.log" 2>/dev/null | grep -c "ERROR\|CRITICAL" || echo "0")"
        echo ""
        
        echo "=========================================="
    } > "$report_file"
    
    info "Reporte diario generado: $report_file"
}

cleanup_old_logs() {
    # Limpiar logs antiguos (mantener últimos 30 días)
    find /var/log/cps-*.log -mtime +30 -delete 2>/dev/null || true
    
    # Limpiar reportes diarios antiguos
    find /var/log/cps-daily-report-*.txt -mtime +30 -delete 2>/dev/null || true
}

run_health_check() {
    local checks_passed=0
    local checks_total=0
    
    info "Ejecutando verificación de salud completa..."
    
    # Lista de verificaciones
    local checks=(
        "check_disk_space"
        "check_memory_usage"
        "check_cpu_usage"
        "check_nginx_status"
        "check_php_fpm_status"
        "check_database_connectivity"
        "check_laravel_errors"
        "check_web_response"
        "check_ssl_certificate"
        "check_laravel_queues"
        "check_file_permissions"
    )
    
    for check in "${checks[@]}"; do
        ((checks_total++))
        if $check; then
            ((checks_passed++))
        fi
        sleep 1  # Pausa entre verificaciones
    done
    
    local health_percentage=$((checks_passed * 100 / checks_total))
    
    if [[ $health_percentage -eq 100 ]]; then
        log "✅ Sistema saludable - $checks_passed/$checks_total verificaciones pasaron"
    elif [[ $health_percentage -ge 80 ]]; then
        warning "⚠️  Sistema mayormente saludable - $checks_passed/$checks_total verificaciones pasaron"
    else
        error "❌ Sistema con problemas - Solo $checks_passed/$checks_total verificaciones pasaron"
    fi
    
    return 0
}

daemon_mode() {
    log "Iniciando modo daemon de monitoreo..."
    
    # Verificar si ya hay una instancia corriendo
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
        error "Monitor ya está corriendo (PID: $(cat "$PID_FILE"))"
        exit 1
    fi
    
    # Guardar PID
    echo $$ > "$PID_FILE"
    
    # Trap para limpiar PID al salir
    trap 'rm -f "$PID_FILE"; log "Monitor detenido"' EXIT
    
    local interval="${1:-300}"  # 5 minutos por defecto
    
    while true; do
        run_health_check
        run_performance_test
        
        # Generar reporte diario a las 00:00
        if [[ $(date +%H%M) == "0000" ]]; then
            generate_status_report
            cleanup_old_logs
        fi
        
        info "Esperando $interval segundos para la próxima verificación..."
        sleep "$interval"
    done
}

show_status() {
    echo -e "${BLUE}Estado del Sistema CPS${NC}"
    echo "========================"
    echo ""
    
    # Servicios
    echo -e "${GREEN}Servicios:${NC}"
    echo "  Nginx:     $(systemctl is-active nginx)"
    echo "  PHP-FPM:   $(systemctl is-active php8.3-fpm)"
    echo "  MySQL:     $(systemctl is-active mysql || systemctl is-active mariadb)"
    echo ""
    
    # Recursos
    echo -e "${GREEN}Recursos:${NC}"
    echo "  Disco:     $(df -h "$APP_DIR" | awk 'NR==2 {print $5 " usado"}')"
    echo "  Memoria:   $(free -h | grep Mem | awk '{print $3 "/" $2 " usada"}')"
    echo ""
    
    # Monitor
    echo -e "${GREEN}Monitor:${NC}"
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
        echo "  Estado:    Activo (PID: $(cat "$PID_FILE"))"
    else
        echo "  Estado:    Inactivo"
    fi
    echo ""
    
    # Logs recientes
    echo -e "${GREEN}Logs recientes:${NC}"
    tail -n 5 "$LOG_FILE" 2>/dev/null || echo "  No hay logs disponibles"
    echo ""
}

usage() {
    cat << EOF
Uso: $0 [COMANDO] [OPCIONES]

Comandos disponibles:
  daemon [INTERVALO]    Ejecutar monitoreo continuo (intervalo en segundos, por defecto 300)
  health               Ejecutar verificación de salud única
  status               Mostrar estado actual del sistema
  test                 Ejecutar prueba de rendimiento
  report               Generar reporte diario
  help                 Mostrar esta ayuda

Ejemplos:
  $0 daemon 300        # Monitorear cada 5 minutos
  $0 health            # Verificación única
  $0 status            # Mostrar estado
  $0 test              # Prueba de rendimiento

Archivos importantes:
  Configuración: $CONFIG_FILE
  Logs: $LOG_FILE
  PID: $PID_FILE

EOF
}

main() {
    # Crear directorio de logs si no existe
    mkdir -p "$(dirname "$LOG_FILE")"
    
    # Verificar dependencias
    if ! check_dependencies; then
        error "Verificación de dependencias falló"
        exit 1
    fi
    
    case "${1:-daemon}" in
        daemon)
            daemon_mode "${2:-300}"
            ;;
        health)
            run_health_check
            ;;
        status)
            show_status
            ;;
        test)
            run_performance_test
            ;;
        report)
            generate_status_report
            ;;
        help|--help|-h)
            usage
            ;;
        *)
            error "Comando desconocido: $1"
            usage
            exit 1
            ;;
    esac
}

# Manejo de señales
trap 'error "Script interrumpido"' INT TERM

# Ejecutar función principal
main "$@"