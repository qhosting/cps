#!/bin/bash

# ==============================================================================
# ENTRYPOINT ALL-IN-ONE PARA EASYPANEL - SISTEMA CPS
# 
# Inicializa TODOS los servicios en un solo contenedor:
# - MariaDB (MySQL)
# - Redis
# - Nginx + PHP-FPM
# - Laravel (migraciones, cache, queue)
# ==============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"; }
log_success() { echo -e "${GREEN}[$(date '+%H:%M:%S')] ✓${NC} $1"; }
log_warning() { echo -e "${YELLOW}[$(date '+%H:%M:%S')] ⚠${NC} $1"; }
log_error() { echo -e "${RED}[$(date '+%H:%M:%S')] ✗${NC} $1"; }

# ==============================================================================
# CONFIGURACIÓN DE VARIABLES
# ==============================================================================

# Variables de base de datos (internas)
export DB_CONNECTION=mysql
export DB_HOST=127.0.0.1
export DB_PORT=3306
export DB_DATABASE=${DB_DATABASE:-cps_database}
export DB_USERNAME=${DB_USERNAME:-cps_user}
export DB_PASSWORD=${DB_PASSWORD:-cps_password_123}
export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-cps_root_password}

# Variables de Redis (internas)
export REDIS_HOST=127.0.0.1
export REDIS_PORT=6379
export REDIS_PASSWORD=null

# Variables de caché y sesiones
export CACHE_DRIVER=redis
export SESSION_DRIVER=redis
export QUEUE_CONNECTION=redis

# Variables de aplicación
export APP_ENV=${APP_ENV:-production}
export APP_DEBUG=${APP_DEBUG:-false}

# ==============================================================================
# INICIALIZACIÓN DE MARIADB
# ==============================================================================

init_mariadb() {
    log_info "Inicializando MariaDB..."
    
    # Crear directorios necesarios
    mkdir -p /var/lib/mysql /var/log/mysql /run/mysqld
    chown -R mysql:mysql /var/lib/mysql /var/log/mysql /run/mysqld
    chmod 755 /run/mysqld
    
    # Inicializar base de datos si no existe
    if [ ! -d "/var/lib/mysql/mysql" ]; then
        log_info "Primera ejecución - inicializando base de datos MariaDB..."
        
        # Inicializar sistema de base de datos
        mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db
        
        # Iniciar MariaDB temporalmente para configurar
        /usr/bin/mysqld_safe --datadir=/var/lib/mysql &
        MYSQL_PID=$!
        
        # Esperar a que MariaDB esté listo
        log_info "Esperando a que MariaDB inicie..."
        for i in {1..30}; do
            if mysqladmin ping -h 127.0.0.1 --silent 2>/dev/null; then
                break
            fi
            sleep 1
        done
        
        # Configurar base de datos y usuario
        log_info "Configurando base de datos y usuarios..."
        mysql -u root << EOF
-- Configurar contraseña de root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Crear usuario de la aplicación
CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'127.0.0.1' IDENTIFIED BY '${DB_PASSWORD}';
CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}';

-- Otorgar privilegios
GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO '${DB_USERNAME}'@'localhost';
GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO '${DB_USERNAME}'@'127.0.0.1';
GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO '${DB_USERNAME}'@'%';

FLUSH PRIVILEGES;
EOF
        
        log_success "Base de datos configurada correctamente"
        
        # Detener MariaDB temporal (supervisord lo reiniciará)
        mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown 2>/dev/null || kill $MYSQL_PID 2>/dev/null || true
        sleep 2
    else
        log_success "Base de datos MariaDB ya existe"
    fi
}

# ==============================================================================
# CONFIGURACIÓN DE LARAVEL
# ==============================================================================

configure_laravel() {
    log_info "Configurando Laravel..."
    
    cd /var/www
    
    # Generar APP_KEY si no existe
    if [ -z "$APP_KEY" ] || [ "$APP_KEY" = "base64:GENERATE_YOUR_APP_KEY_HERE" ]; then
        APP_KEY=$(php -r "echo 'base64:' . base64_encode(random_bytes(32));")
        export APP_KEY
        log_success "APP_KEY generada"
    fi
    
    # Configurar APP_URL
    if [ -z "$APP_URL" ]; then
        if [ -n "$EASYPANEL_DOMAIN" ]; then
            APP_URL="https://${EASYPANEL_DOMAIN}"
        else
            APP_URL="http://localhost"
        fi
        export APP_URL
    fi
    
    # Crear archivo .env
    log_info "Creando archivo .env..."
    cat > .env << EOF
# ==============================================================================
# CPS SYSTEM - CONFIGURACIÓN ALL-IN-ONE (AUTO-GENERADO)
# Generado: $(date)
# ==============================================================================

# === APLICACIÓN ===
APP_NAME=${APP_NAME:-CPS}
APP_ENV=${APP_ENV:-production}
APP_KEY=${APP_KEY}
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=${APP_URL}

# === EASYPANEL ===
EASYPANEL=${EASYPANEL:-false}
EASYPANEL_PROJECT=${EASYPANEL_PROJECT:-}
EASYPANEL_DOMAIN=${EASYPANEL_DOMAIN:-}

# === BASE DE DATOS (INTERNA) ===
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=${DB_DATABASE}
DB_USERNAME=${DB_USERNAME}
DB_PASSWORD=${DB_PASSWORD}

# === REDIS (INTERNO) ===
REDIS_HOST=127.0.0.1
REDIS_PORT=6379
REDIS_PASSWORD=null

# === CACHÉ Y SESIONES ===
CACHE_DRIVER=redis
SESSION_DRIVER=redis
SESSION_LIFETIME=120
SESSION_SECURE_COOKIE=true
QUEUE_CONNECTION=redis

# === LOGGING ===
LOG_CHANNEL=stack
LOG_LEVEL=notice

# === EMAIL ===
MAIL_MAILER=smtp
MAIL_HOST=${MAIL_HOST:-smtp.mailtrap.io}
MAIL_PORT=${MAIL_PORT:-587}
MAIL_USERNAME=${MAIL_USERNAME:-}
MAIL_PASSWORD=${MAIL_PASSWORD:-}
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS:-noreply@localhost}
MAIL_FROM_NAME="${MAIL_FROM_NAME:-CPS System}"

# === CPS LICENSE ===
APP_LICENSE=${APP_LICENSE:-}
APP_VERSION=${APP_VERSION:-120.55.1}
API_TOKEN=${API_TOKEN:-}

# === BROADCASTING ===
BROADCAST_DRIVER=log
EOF
    
    log_success "Archivo .env creado"
    
    # Configurar permisos
    chown -R app:app /var/www
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache
}

# ==============================================================================
# ESPERAR SERVICIOS Y EJECUTAR MIGRACIONES
# ==============================================================================

run_migrations() {
    log_info "Esperando a que los servicios estén listos..."
    
    # Esperar MariaDB
    for i in {1..60}; do
        if nc -z 127.0.0.1 3306 2>/dev/null; then
            log_success "MariaDB disponible"
            break
        fi
        sleep 1
    done
    
    # Esperar Redis
    for i in {1..30}; do
        if nc -z 127.0.0.1 6379 2>/dev/null; then
            log_success "Redis disponible"
            break
        fi
        sleep 1
    done
    
    # Ejecutar migraciones
    cd /var/www
    
    if [ -f "artisan" ]; then
        log_info "Ejecutando migraciones..."
        
        # Intentar migraciones
        if php artisan migrate --force 2>/dev/null; then
            log_success "Migraciones ejecutadas"
        else
            log_warning "Migraciones pueden estar ya aplicadas o hubo un error"
        fi
        
        # Optimizar Laravel
        log_info "Optimizando Laravel..."
        php artisan config:cache 2>/dev/null || true
        php artisan route:cache 2>/dev/null || true
        php artisan view:cache 2>/dev/null || true
        
        log_success "Laravel optimizado"
    fi
}

# ==============================================================================
# FUNCIÓN PRINCIPAL
# ==============================================================================

main() {
    echo ""
    echo "=============================================="
    echo "   CPS SYSTEM - ALL-IN-ONE PARA EASYPANEL"
    echo "=============================================="
    echo ""
    
    # Verificar ionCube
    log_info "Verificando ionCube Loader..."
    if php -v 2>&1 | grep -qi "ioncube"; then
        log_success "ionCube Loader activo"
    else
        log_error "ionCube Loader NO está cargado - verificar configuración"
        php -v 2>&1 | head -5
    fi
    
    # Diagnóstico de ionCube y archivos encriptados
    log_info "Diagnóstico de archivos encriptados..."
    if head -c 100 /var/www/artisan 2>/dev/null | grep -q "ionCube"; then
        log_warning "El archivo artisan está ENCRIPTADO con ionCube"
        log_warning "Los workers de Laravel requieren licencia ionCube válida"
    else
        log_success "El archivo artisan NO está encriptado"
    fi
    
    # Test de PHP artisan básico
    log_info "Probando PHP artisan..."
    cd /var/www
    if php artisan --version 2>&1; then
        log_success "PHP artisan funciona correctamente"
    else
        log_error "ERROR ejecutando PHP artisan:"
        php artisan --version 2>&1 || true
    fi
    
    # Verificar configuración de Nginx
    log_info "Verificando configuración de Nginx..."
    mkdir -p /run/nginx /var/log/nginx
    if nginx -t 2>&1; then
        log_success "Configuración de Nginx válida"
    else
        log_error "Error en configuración de Nginx:"
        nginx -t 2>&1
    fi
    
    # Inicializar MariaDB
    init_mariadb
    
    # Configurar Laravel
    configure_laravel
    
    # Crear directorios de logs
    mkdir -p /var/log/supervisor
    
    # Mostrar información
    echo ""
    log_info "=============================================="
    log_info "Configuración completada:"
    log_info "  - APP_URL: ${APP_URL}"
    log_info "  - DB_DATABASE: ${DB_DATABASE}"
    log_info "  - REDIS: 127.0.0.1:6379"
    log_info "=============================================="
    echo ""
    
    # Iniciar supervisord que ejecutará las migraciones después
    log_success "Iniciando todos los servicios con Supervisord..."
    
    # Ejecutar migraciones en background después de que los servicios inicien
    (sleep 45 && run_migrations) &
    
    # Ejecutar comando pasado (supervisord)
    exec "$@"
}

# Ejecutar
main "$@"
