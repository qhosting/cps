#!/bin/bash

# =============================================================================
# SCRIPT DE ACTUALIZACIÓN AUTOMÁTICA PARA SISTEMA CPS
# Opción D - Actualización Automática con Backup
# =============================================================================

set -euo pipefail

# Configuración
APP_NAME="CPS License Management"
APP_DIR="/var/www/system"
LOG_FILE="/var/log/cps-update.log"
BACKUP_DIR="/opt/backups/cps"
REPO_URL="https://github.com/qhosting/cps.git"
BRANCH="master"
TEMP_DIR="/tmp/cps-update-$$"

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
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}[INFO] $1${NC}" | tee -a "$LOG_FILE"
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "Este script debe ejecutarse como root"
    fi
}

create_backup() {
    local backup_type="$1"
    local backup_name="${backup_type}_$(date +%Y%m%d_%H%M%S)"
    local backup_path="$BACKUP_DIR/$backup_name"
    
    log "Creando backup $backup_type: $backup_name"
    
    mkdir -p "$BACKUP_DIR"
    
    case "$backup_type" in
        full)
            # Backup completo de la aplicación y base de datos
            log "Backup completo de aplicación..."
            tar -czf "$backup_path-app.tar.gz" -C "$(dirname "$APP_DIR")" "$(basename "$APP_DIR")"
            
            log "Backup de base de datos..."
            mysqldump -u username -p password cps_database > "$backup_path-db.sql"
            ;;
        files)
            # Solo archivos de la aplicación
            log "Backup de archivos de aplicación..."
            tar -czf "$backup_path-files.tar.gz" -C "$(dirname "$APP_DIR")" "$(basename "$APP_DIR")"
            ;;
        db)
            # Solo base de datos
            log "Backup de base de datos..."
            mysqldump -u username -p password cps_database > "$backup_path-db.sql"
            ;;
    esac
    
    # Comprimir backup completo
    if [[ "$backup_type" == "full" ]]; then
        tar -czf "$backup_path.tar.gz" -C "$BACKUP_DIR" "$(basename "$backup_path-app.tar.gz")" "$(basename "$backup_path-db.sql")"
        rm -f "$backup_path-app.tar.gz" "$backup_path-db.sql"
    fi
    
    log "Backup creado: $backup_path${backup_type:+.$backup_type}"
}

enable_maintenance_mode() {
    log "Habilitando modo mantenimiento..."
    
    cd "$APP_DIR"
    
    # Crear archivo de modo mantenimiento si no existe
    if [[ ! -f "storage/framework/down" ]]; then
        php artisan down --message="Sistema en mantenimiento para actualización"
        log "Modo mantenimiento habilitado"
    else
        warning "Modo mantenimiento ya está habilitado"
    fi
}

disable_maintenance_mode() {
    log "Deshabilitando modo mantenimiento..."
    
    cd "$APP_DIR"
    
    # Remover archivo de modo mantenimiento
    if [[ -f "storage/framework/down" ]]; then
        php artisan up
        log "Modo mantenimiento deshabilitado"
    else
        info "Modo mantenimiento no estaba habilitado"
    fi
}

stop_services() {
    log "Deteniendo servicios..."
    
    # Detener servicios que puedan estar usando archivos
    systemctl stop php8.3-fpm || true
    systemctl stop nginx || true
    
    # Esperar un momento para que los procesos terminen
    sleep 3
    
    log "Servicios detenidos"
}

start_services() {
    log "Iniciando servicios..."
    
    # Iniciar servicios
    systemctl start nginx
    systemctl start php8.3-fpm
    
    # Esperar a que los servicios estén listos
    sleep 5
    
    # Verificar que estén funcionando
    if systemctl is-active --quiet nginx && systemctl is-active --quiet php8.3-fpm; then
        log "Servicios iniciados correctamente"
    else
        error "Error al iniciar servicios"
    fi
}

check_git_status() {
    local current_commit=$(git rev-parse HEAD)
    local remote_commit=$(git rev-parse origin/$BRANCH)
    
    if [[ "$current_commit" == "$remote_commit" ]]; then
        info "La aplicación ya está actualizada (commit: $current_commit)"
        return 1
    else
        log "Nueva versión disponible:"
        info "  Actual: $current_commit"
        info "  Remota: $remote_commit"
        return 0
    fi
}

fetch_updates() {
    log "Obteniendo actualizaciones del repositorio..."
    
    cd "$APP_DIR"
    
    # Guardar cambios locales si existen
    if ! git diff-index --quiet HEAD --; then
        warning "Hay cambios locales no confirmados"
        git stash push -m "Auto-stash before update $(date)"
    fi
    
    # Obtener actualizaciones
    git fetch origin
    
    if ! check_git_status; then
        return 1
    fi
    
    # Mostrar cambios
    log "Mostrando cambios a aplicar:"
    git log --oneline HEAD..origin/$BRANCH
    
    return 0
}

apply_updates() {
    log "Aplicando actualizaciones..."
    
    cd "$APP_DIR"
    
    # Hacer pull de los cambios
    if ! git pull origin $BRANCH; then
        error "Error al aplicar actualizaciones"
        return 1
    fi
    
    log "Actualizaciones aplicadas exitosamente"
    return 0
}

update_dependencies() {
    log "Actualizando dependencias de Composer..."
    
    cd "$APP_DIR"
    
    # Instalar/actualizar dependencias
    composer install --optimize-autoloader --no-dev
    
    log "Dependencias actualizadas"
}

run_migrations() {
    log "Ejecutando migraciones de base de datos..."
    
    cd "$APP_DIR"
    
    # Verificar estado de migraciones pendientes
    local pending_migrations=$(php artisan migrate:status | grep "No" | wc -l)
    
    if [[ $pending_migrations -gt 0 ]]; then
        log "Ejecutando $pending_migrations migraciones pendientes..."
        php artisan migrate --force
        log "Migraciones completadas"
    else
        info "No hay migraciones pendientes"
    fi
}

clear_caches() {
    log "Limpiando caches..."
    
    cd "$APP_DIR"
    
    # Limpiar todos los caches
    php artisan cache:clear || true
    php artisan config:clear || true
    php artisan route:clear || true
    php artisan view:clear || true
    
    log "Caches limpiados"
}

optimize_application() {
    log "Optimizando aplicación para producción..."
    
    cd "$APP_DIR"
    
    # Optimizaciones para producción
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    
    log "Aplicación optimizada"
}

run_tests() {
    log "Ejecutando verificaciones post-actualización..."
    
    cd "$APP_DIR"
    
    # Verificaciones básicas
    local checks_passed=0
    local checks_total=0
    
    # Verificar que la aplicación responde
    ((checks_total++))
    if php artisan --version > /dev/null 2>&1; then
        ((checks_passed++))
        info "✓ Comando artisan funcional"
    else
        error "✗ Error en comando artisan"
    fi
    
    # Verificar conectividad de base de datos
    ((checks_total++))
    if php artisan migrate:status > /dev/null 2>&1; then
        ((checks_passed++))
        info "✓ Conectividad de base de datos OK"
    else
        error "✗ Error de conectividad con base de datos"
    fi
    
    # Verificar permisos de archivos
    ((checks_total++))
    if [[ -w "$APP_DIR/storage" ]] && [[ -w "$APP_DIR/bootstrap/cache" ]]; then
        ((checks_passed++))
        info "✓ Permisos de archivos OK"
    else
        error "✗ Error de permisos de archivos"
    fi
    
    # Verificar que el servidor web responde
    ((checks_total++))
    if curl -s "http://localhost" > /dev/null 2>&1; then
        ((checks_passed++))
        info "✓ Servidor web responde"
    else
        error "✗ Servidor web no responde"
    fi
    
    local success_rate=$((checks_passed * 100 / checks_total))
    
    if [[ $success_rate -eq 100 ]]; then
        log "✅ Todas las verificaciones pasaron ($checks_passed/$checks_total)"
    else
        warning "⚠️  Algunas verificaciones fallaron ($checks_passed/$checks_total)"
    fi
}

rollback_update() {
    local backup_file="$1"
    
    log "Iniciando rollback desde backup: $backup_file"
    
    if [[ ! -f "$backup_file" ]]; then
        error "Archivo de backup no encontrado: $backup_file"
        return 1
    fi
    
    # Detener servicios
    stop_services
    
    # Restaurar backup
    log "Restaurando backup..."
    cd "$(dirname "$APP_DIR")"
    tar -xzf "$backup_file" --strip-components=0
    
    # Reiniciar servicios
    start_services
    
    log "Rollback completado"
}

schedule_update() {
    local schedule_time="$1"
    local script_path="$(realpath "$0")"
    
    log "Programando actualización para: $schedule_time"
    
    # Agregar a crontab
    (crontab -l 2>/dev/null; echo "$schedule_time $script_path auto") | crontab -
    
    log "Actualización programada exitosamente"
}

cleanup_old_backups() {
    log "Limpiando backups antiguos..."
    
    # Mantener solo los últimos 30 días de backups
    find "$BACKUP_DIR" -name "*.tar.gz" -mtime +30 -delete 2>/dev/null || true
    find "$BACKUP_DIR" -name "*.sql" -mtime +30 -delete 2>/dev/null || true
    
    log "Limpieza de backups completada"
}

show_update_info() {
    log "Información de actualización:"
    
    if [[ -d "$APP_DIR/.git" ]]; then
        cd "$APP_DIR"
        local current_commit=$(git rev-parse --short HEAD)
        local remote_commit=$(git rev-parse --short origin/$BRANCH 2>/dev/null || echo "N/A")
        local branch=$(git branch --show-current)
        local last_update=$(git log -1 --format=%cd --date=short)
        
        info "  Rama actual: $branch"
        info "  Commit actual: $current_commit"
        info "  Commit remoto: $remote_commit"
        info "  Última actualización: $last_update"
        info "  Directorio: $APP_DIR"
    else
        warning "Repositorio Git no encontrado"
    fi
}

usage() {
    cat << EOF
Uso: $0 [COMANDO] [OPCIONES]

Comandos disponibles:
  auto              Actualización automática con backup
  check             Verificar actualizaciones disponibles
  force             Forzar actualización sin verificar
  rollback FILE     Restaurar desde backup específico
  schedule TIME     Programar actualización automática
  status            Mostrar información del repositorio
  cleanup           Limpiar backups antiguos
  help              Mostrar esta ayuda

Opciones:
  --no-backup       No crear backup antes de actualizar
  --force           Forzar actualización sin confirmaciones
  --dry-run         Simular actualización sin aplicar cambios

Ejemplos:
  $0 auto                    # Actualización completa con backup
  $0 check                   # Verificar actualizaciones
  $0 force                   # Forzar actualización
  $0 rollback backup.tar.gz  # Restaurar desde backup
  $0 schedule "0 2 * * 0"    # Actualizar cada domingo a las 2 AM
  $0 status                  # Mostrar información del repositorio

Archivos importantes:
  Logs: $LOG_FILE
  Backups: $BACKUP_DIR

EOF
}

main() {
    local command="${1:-auto}"
    local no_backup=false
    local force=false
    local dry_run=false
    
    # Parsear opciones
    shift
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --no-backup)
                no_backup=true
                shift
                ;;
            --force)
                force=true
                shift
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            *)
                shift
                ;;
        esac
    done
    
    # Crear directorio de logs si no existe
    mkdir -p "$(dirname "$LOG_FILE")"
    
    # Verificaciones previas
    check_root
    
    case "$command" in
        auto)
            log "Iniciando actualización automática de $APP_NAME"
            
            # Mostrar información actual
            show_update_info
            
            # Verificar si hay actualizaciones
            if ! fetch_updates; then
                info "No hay actualizaciones disponibles"
                exit 0
            fi
            
            # Confirmar actualización si no es forzada
            if [[ "$force" != true ]] && [[ "$dry_run" != true ]]; then
                echo -e "${YELLOW}¿Continuar con la actualización? [y/N]${NC}"
                read -r confirm
                if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                    info "Actualización cancelada por el usuario"
                    exit 0
                fi
            fi
            
            # Crear backup
            if [[ "$no_backup" != true ]]; then
                create_backup "full"
            else
                warning "Backup omitido por opción del usuario"
            fi
            
            # Proceso de actualización
            enable_maintenance_mode
            stop_services
            
            if [[ "$dry_run" != true ]]; then
                apply_updates
                update_dependencies
                run_migrations
                clear_caches
                optimize_application
            else
                info "Dry run: No se aplicaron cambios"
            fi
            
            start_services
            disable_maintenance_mode
            
            if [[ "$dry_run" != true ]]; then
                run_tests
            fi
            
            cleanup_old_backups
            
            log "¡Actualización completada exitosamente!"
            ;;
            
        check)
            show_update_info
            if fetch_updates; then
                info "Hay actualizaciones disponibles"
            else
                info "No hay actualizaciones disponibles"
            fi
            ;;
            
        force)
            log "Forzando actualización..."
            main "auto" "--force" "$@"
            ;;
            
        rollback)
            local backup_file="$2"
            if [[ -z "$backup_file" ]]; then
                error "Especifica un archivo de backup"
                exit 1
            fi
            rollback_update "$backup_file"
            ;;
            
        schedule)
            local schedule_time="$2"
            if [[ -z "$schedule_time" ]]; then
                error "Especifica un tiempo de programación (formato cron)"
                exit 1
            fi
            schedule_update "$schedule_time"
            ;;
            
        status)
            show_update_info
            ;;
            
        cleanup)
            cleanup_old_backups
            ;;
            
        help|--help|-h)
            usage
            ;;
            
        *)
            error "Comando desconocido: $command"
            usage
            exit 1
            ;;
    esac
}

# Manejo de señales
trap 'error "Script interrumpido"' INT TERM

# Ejecutar función principal
main "$@"