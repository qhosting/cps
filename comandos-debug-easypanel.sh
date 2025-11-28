#!/bin/bash

# ==============================================================================
# COMANDOS DE DEBUG Y VERIFICACIÓN PARA EASYPANEL
# ==============================================================================
# 
# Script de utilidades para verificar y debuggear las variables de entorno
# y la configuración del sistema CPS en EasyPanel.
#
# Uso: ./comandos-debug-easypanel.sh
# ==============================================================================

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_header() {
    echo
    echo -e "${PURPLE}===================================================${NC}"
    echo -e "${PURPLE} $1${NC}"
    echo -e "${PURPLE}===================================================${NC}"
    echo
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✅ SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[⚠️  WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[❌ ERROR]${NC} $1"
}

print_check() {
    echo -e "${CYAN}[CHECK]${NC} $1"
}

# Función para verificar conectividad
check_connection() {
    local host=$1
    local port=$2
    local service=$3
    
    if nc -z $host $port 2>/dev/null; then
        print_success "$service: Conectado ($host:$port)"
        return 0
    else
        print_error "$service: No disponible ($host:$port)"
        return 1
    fi
}

# Verificar variables críticas
check_critical_vars() {
    print_header "VERIFICANDO VARIABLES CRÍTICAS"
    
    local critical_vars=(
        "APP_NAME"
        "APP_ENV"
        "APP_KEY"
        "APP_DEBUG"
        "DB_HOST"
        "DB_DATABASE"
        "DB_USERNAME"
        "DB_PASSWORD"
        "REDIS_HOST"
        "REDIS_PORT"
        "MAIL_HOST"
        "MAIL_USERNAME"
    )
    
    local missing_vars=()
    
    for var in "${critical_vars[@]}"; do
        if [ -z "${!var}" ]; then
            print_error "❌ $var: NO DEFINIDA"
            missing_vars+=("$var")
        else
            # Ocultar valores sensibles
            if [[ "$var" == *"PASSWORD"* ]] || [[ "$var" == *"SECRET"* ]] || [[ "$var" == *"KEY"* ]]; then
                local masked_value="${!var:0:8}..."
                print_success "✅ $var: $masked_value"
            else
                print_success "✅ $var: ${!var}"
            fi
        fi
    done
    
    if [ ${#missing_vars[@]} -gt 0 ]; then
        echo
        print_error "Variables faltantes: ${missing_vars[*]}"
        return 1
    else
        echo
        print_success "Todas las variables críticas están definidas"
        return 0
    fi
}

# Verificar variables de EasyPanel
check_easypanel_vars() {
    print_header "VARIABLES DE EASYPANEL"
    
    if [ "$EASYPANEL" = "true" ]; then
        print_success "EasyPanel detectado: ✅"
        print_info "Proyecto: $EASYPANEL_PROJECT"
        print_info "Dominio: $EASYPANEL_DOMAIN"
        print_info "Puerto: $PORT"
        print_info "Host: $HOST"
    else
        print_warning "EasyPanel no detectado o no configurado"
        print_info "EASYPANEL: ${EASYPANEL:-NO DEFINIDO}"
    fi
}

# Verificar conectividad de servicios
check_services() {
    print_header "CONECTIVIDAD DE SERVICIOS"
    
    local mysql_ok=0
    local redis_ok=0
    
    # Verificar MySQL
    print_check "Verificando MySQL..."
    if check_connection "${DB_HOST:-mysql}" "${DB_PORT:-3306}" "MySQL"; then
        mysql_ok=1
    fi
    
    # Verificar Redis
    print_check "Verificando Redis..."
    if check_connection "${REDIS_HOST:-redis}" "${REDIS_PORT:-6379}" "Redis"; then
        redis_ok=1
    fi
    
    # Verificar puertos del contenedor
    print_check "Verificando puertos del contenedor..."
    if netstat -tlnp 2>/dev/null | grep -q ":80 "; then
        print_success "Puerto 80 (HTTP): Abierto"
    else
        print_warning "Puerto 80 (HTTP): Cerrado o no accesible"
    fi
    
    if netstat -tlnp 2>/dev/null | grep -q ":443 "; then
        print_success "Puerto 443 (HTTPS): Abierto"
    else
        print_warning "Puerto 443 (HTTPS): Cerrado o no accesible"
    fi
}

# Verificar PHP y extensiones
check_php_environment() {
    print_header "ENTORNO PHP"
    
    # Versión de PHP
    local php_version=$(php -v | head -n1 | cut -d' ' -f2)
    print_info "Versión PHP: $php_version"
    
    # Verificar extensiones críticas
    local extensions=("pdo" "pdo_mysql" "redis" "gd" "curl" "openssl" "json" "mbstring" "zip")
    
    print_check "Verificando extensiones PHP..."
    for ext in "${extensions[@]}"; do
        if php -m | grep -q "$ext"; then
            print_success "✅ $ext"
        else
            print_error "❌ $ext"
        fi
    done
    
    # Verificar ionCube
    print_check "Verificando ionCube..."
    if php -v | grep -q "ionCube"; then
        local ioncube_version=$(php -v | grep ionCube | head -n1 | cut -d'(' -f2 | cut -d')' -f1)
        print_success "✅ ionCube: $ioncube_version"
    else
        print_error "❌ ionCube no detectado"
    fi
}

# Verificar Laravel
check_laravel_environment() {
    print_header "ENTORNO LARAVEL"
    
    # Verificar que estamos en un proyecto Laravel
    if [ -f "artisan" ]; then
        print_success "✅ Proyecto Laravel detectado"
        
        # Versión de Laravel
        if command -v php &> /dev/null; then
            local laravel_version=$(php artisan --version 2>/dev/null | grep -o "Laravel [0-9.]\+" | cut -d' ' -f2)
            if [ -n "$laravel_version" ]; then
                print_info "Versión Laravel: $laravel_version"
            fi
        fi
        
        # Verificar cache de configuración
        if [ -f "bootstrap/cache/config.php" ]; then
            print_success "✅ Cache de configuración disponible"
        else
            print_warning "⚠️  Cache de configuración no disponible"
        fi
        
        # Verificar cache de rutas
        if [ -f "bootstrap/cache/routes-v7.php" ] || [ -f "bootstrap/cache/routes.php" ]; then
            print_success "✅ Cache de rutas disponible"
        else
            print_warning "⚠️  Cache de rutas no disponible"
        fi
        
        # Verificar permisos
        if [ -w "storage" ]; then
            print_success "✅ Permisos de escritura en storage"
        else
            print_error "❌ Sin permisos de escritura en storage"
        fi
        
        if [ -w "bootstrap/cache" ]; then
            print_success "✅ Permisos de escritura en bootstrap/cache"
        else
            print_error "❌ Sin permisos de escritura en bootstrap/cache"
        fi
        
    else
        print_error "❌ No se detectó proyecto Laravel (artisan no encontrado)"
    fi
}

# Probar conectividad de base de datos
test_database_connection() {
    print_header "PRUEBA DE CONECTIVIDAD DE BASE DE DATOS"
    
    if command -v mysql &> /dev/null; then
        print_check "Probando conexión a MySQL..."
        if mysql -h"${DB_HOST:-mysql}" -P"${DB_PORT:-3306}" -u"${DB_USERNAME}" -p"${DB_PASSWORD}" -e "SELECT 1;" &>/dev/null; then
            print_success "✅ Conexión a MySQL exitosa"
            
            # Verificar que la base de datos existe
            if mysql -h"${DB_HOST:-mysql}" -P"${DB_PORT:-3306}" -u"${DB_USERNAME}" -p"${DB_PASSWORD}" -e "USE ${DB_DATABASE}; SELECT DATABASE();" &>/dev/null; then
                print_success "✅ Base de datos '${DB_DATABASE}' existe y es accesible"
            else
                print_error "❌ Base de datos '${DB_DATABASE}' no es accesible"
            fi
            
        else
            print_error "❌ No se pudo conectar a MySQL"
            print_info "Verificar credenciales: ${DB_USERNAME}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
        fi
    else
        print_warning "MySQL client no disponible"
    fi
}

# Probar conectividad de Redis
test_redis_connection() {
    print_header "PRUEBA DE CONECTIVIDAD DE REDIS"
    
    if command -v redis-cli &> /dev/null; then
        print_check "Probando conexión a Redis..."
        if redis-cli -h"${REDIS_HOST:-redis}" -p"${REDIS_PORT:-6379}" ping &>/dev/null; then
            print_success "✅ Conexión a Redis exitosa"
            
            # Verificar operaciones básicas
            if redis-cli -h"${REDIS_HOST:-redis}" -p"${REDIS_PORT:-6379}" set "test_key" "test_value" &>/dev/null; then
                local test_value=$(redis-cli -h"${REDIS_HOST:-redis}" -p"${REDIS_PORT:-6379}" get "test_key")
                if [ "$test_value" = "test_value" ]; then
                    print_success "✅ Operaciones de lectura/escritura funcionando"
                    redis-cli -h"${REDIS_HOST:-redis}" -p"${REDIS_PORT:-6379}" del "test_key" &>/dev/null
                else
                    print_error "❌ Problemas con operaciones de Redis"
                fi
            else
                print_error "❌ No se pudo escribir en Redis"
            fi
            
        else
            print_error "❌ No se pudo conectar a Redis"
            print_info "Verificar: ${REDIS_HOST}:${REDIS_PORT}"
        fi
    else
        print_warning "Redis CLI no disponible"
    fi
}

# Verificar logs
check_logs() {
    print_header "REVISIÓN DE LOGS"
    
    # Logs de Laravel
    if [ -f "storage/logs/laravel.log" ]; then
        print_check "Logs de Laravel:"
        local error_count=$(tail -100 storage/logs/laravel.log | grep -i "error\|exception\|failed" | wc -l)
        if [ "$error_count" -eq 0 ]; then
            print_success "✅ No hay errores recientes en Laravel"
        else
            print_warning "⚠️  $error_count líneas con errores/en excepciones encontradas"
            print_info "Últimas 5 líneas con errores:"
            tail -100 storage/logs/laravel.log | grep -i "error\|exception" | tail -5 | sed 's/^/    /'
        fi
    else
        print_warning "Log de Laravel no encontrado"
    fi
    
    # Logs de PHP
    if [ -f "/var/log/php_errors.log" ]; then
        print_check "Logs de PHP:"
        local php_errors=$(tail -50 /var/log/php_errors.log | grep -i "error\|warning" | wc -l)
        if [ "$php_errors" -eq 0 ]; then
            print_success "✅ No hay errores recientes en PHP"
        else
            print_warning "⚠️  $php_errors errores/warnings en PHP"
        fi
    else
        print_warning "Log de PHP no encontrado en /var/log/php_errors.log"
    fi
}

# Generar reporte completo
generate_report() {
    local report_file="debug-report-$(date +%Y%m%d_%H%M%S).txt"
    
    print_header "GENERANDO REPORTE COMPLETO"
    
    {
        echo "REPORTE DE DEBUG - SISTEMA CPS EASYPANEL"
        echo "Generado: $(date)"
        echo "==========================================="
        echo
        
        echo "VARIABLES DE ENTORNO:"
        printenv | grep -E "(APP|DB|REDIS|MAIL|EASYPANEL)" | sort
        echo
        
        echo "ESTADO DE CONTENEDORES:"
        docker-compose ps 2>/dev/null || echo "docker-compose no disponible"
        echo
        
        echo "ULTIMAS 20 LINEAS DE LOGS LARAVEL:"
        if [ -f "storage/logs/laravel.log" ]; then
            tail -20 storage/logs/laravel.log
        else
            echo "Log de Laravel no encontrado"
        fi
        echo
        
        echo "CONFIGURACIÓN PHP RELEVANTE:"
        php -i | grep -E "(memory_limit|upload_max_filesize|max_execution_time|ioncube)" | head -10
        
    } > "$report_file"
    
    print_success "Reporte guardado en: $report_file"
    print_info "Tamaño: $(du -h "$report_file" | cut -f1)"
}

# Mostrar comandos útiles
show_useful_commands() {
    print_header "COMANDOS ÚTILES"
    
    echo -e "${CYAN}📋 Ver todas las variables de entorno:${NC}"
    echo "printenv | grep -E '(APP|DB|REDIS|MAIL)'"
    echo
    
    echo -e "${CYAN}🗄️  Probar conexión a MySQL:${NC}"
    echo "mysql -h\$DB_HOST -P\$DB_PORT -u\$DB_USERNAME -p\$DB_PASSWORD -e 'SELECT 1;'"
    echo
    
    echo -e "${CYAN}📦 Probar conexión a Redis:${NC}"
    echo "redis-cli -h\$REDIS_HOST -p\$REDIS_PORT ping"
    echo
    
    echo -e "${CYAN}🐘 Verificar extensiones PHP:${NC}"
    echo "php -m | grep -E '(pdo|redis|ioncube)'"
    echo
    
    echo -e "${CYAN}🔧 Limpiar cache de Laravel:${NC}"
    echo "php artisan cache:clear && php artisan config:clear && php artisan route:clear"
    echo
    
    echo -e "${CYAN}📊 Estado de Laravel:${NC}"
    echo "php artisan about"
    echo
    
    echo -e "${CYAN}🛠️  Ver logs en tiempo real:${NC}"
    echo "tail -f storage/logs/laravel.log"
    echo
    
    echo -e "${CYAN}🌐 Ver configuración web:${NC}"
    echo "curl -I http://localhost/"
    echo
}

# Menú principal
main_menu() {
    while true; do
        echo
        print_header "MENU DE DEBUG - EASYPANEL CPS"
        echo "1) Verificar variables críticas"
        echo "2) Verificar variables de EasyPanel"
        echo "3) Verificar conectividad de servicios"
        echo "4) Verificar entorno PHP"
        echo "5) Verificar entorno Laravel"
        echo "6) Probar conexión a base de datos"
        echo "7) Probar conexión a Redis"
        echo "8) Revisar logs"
        echo "9) Generar reporte completo"
        echo "10) Ver comandos útiles"
        echo "0) Salir"
        echo
        read -p "Selecciona una opción: " choice
        
        case $choice in
            1) check_critical_vars ;;
            2) check_easypanel_vars ;;
            3) check_services ;;
            4) check_php_environment ;;
            5) check_laravel_environment ;;
            6) test_database_connection ;;
            7) test_redis_connection ;;
            8) check_logs ;;
            9) generate_report ;;
            10) show_useful_commands ;;
            0) print_info "Saliendo..."; exit 0 ;;
            *) print_error "Opción inválida";;
        esac
        
        echo
        read -p "Presiona Enter para continuar..."
    done
}

# Función principal
main() {
    print_info "Iniciando herramientas de debug para EasyPanel..."
    
    # Verificar que estamos en el directorio correcto
    if [ ! -f "docker-compose.yml" ] && [ ! -f "artisan" ]; then
        print_error "No se detectó proyecto Laravel o docker-compose.yml"
        print_info "Ejecuta este script desde el directorio raíz del proyecto"
        exit 1
    fi
    
    # Si se proporciona un argumento, ejecutar directamente esa función
    if [ $# -gt 0 ]; then
        case $1 in
            "vars") check_critical_vars ;;
            "easypanel") check_easypanel_vars ;;
            "services") check_services ;;
            "php") check_php_environment ;;
            "laravel") check_laravel_environment ;;
            "mysql") test_database_connection ;;
            "redis") test_redis_connection ;;
            "logs") check_logs ;;
            "report") generate_report ;;
            "commands") show_useful_commands ;;
            *) print_error "Función desconocida: $1" ;;
        esac
    else
        # Mostrar menú interactivo
        main_menu
    fi
}

# Verificar dependencias
command -v nc &> /dev/null || { print_error "netcat (nc) no está instalado. Instálalo para verificar conectividad."; }
command -v docker &> /dev/null || { print_warning "Docker no está disponible en este contenedor"; }

# Ejecutar función principal
main "$@"