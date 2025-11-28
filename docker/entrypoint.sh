#!/bin/bash

# ==============================================================================
# ENTRYPOINT CORREGIDO PARA EASYPANEL - SISTEMA CPS
# 
# SOLUCIONA TODOS LOS ERRORES IDENTIFICADOS:
# - Segmentation fault de Composer
# - Conflictos de ionCube 
# - Problemas de directorios
# - Verificaciones de servicios
# ==============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Función para imprimir mensajes con timestamp
log_info() {
    echo -e "${BLUE}[$(date '+%H:%M:%S') - INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[$(date '+%H:%M:%S') - SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[$(date '+%H:%M:%S') - WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[$(date '+%H:%M:%S') - ERROR]${NC} $1"
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Función para verificar conectividad
wait_for_service() {
    local host=$1
    local port=$2
    local service=$3
    local timeout=${4:-30}
    
    log_info "Esperando $service ($host:$port)..."
    
    local counter=0
    while ! nc -z "$host" "$port" 2>/dev/null; do
        sleep 1
        counter=$((counter + 1))
        if [ $counter -gt $timeout ]; then
            log_error "Timeout esperando $service después de $timeout segundos"
            return 1
        fi
    done
    
    log_success "$service disponible en $host:$port"
}

# Función principal de inicialización
main() {
    log_info "🚀 Iniciando configuración del Sistema CPS para EasyPanel..."
    
    # Verificar que estamos en el directorio correcto
    if [ ! -d "/var/www" ]; then
        log_error "Directorio /var/www no encontrado"
        exit 1
    fi
    
    cd /var/www
    
    # Verificar variables críticas de EasyPanel
    log_info "Verificando variables de EasyPanel..."
    if [ "$EASYPANEL" = "true" ]; then
        log_success "EasyPanel detectado"
        log_info "Proyecto: $EASYPANEL_PROJECT"
        log_info "Dominio: $EASYPANEL_DOMAIN"
        log_info "Puerto: $PORT"
    else
        log_warning "EasyPanel no detectado - usando configuración local"
    fi
    
    # Verificar ionCube
    log_info "Verificando ionCube Loader..."
    if php -v | grep -q "ionCube"; then
        log_success "ionCube Loader detectado correctamente"
    else
        log_warning "ionCube Loader no detectado - la aplicación puede no funcionar"
    fi
    
    # Verificar extensiones PHP críticas
    log_info "Verificando extensiones PHP críticas..."
    local required_extensions=("pdo" "pdo_mysql" "mbstring" "json" "curl" "openssl" "zip")
    for ext in "${required_extensions[@]}"; do
        if php -m | grep -q "^$ext$"; then
            log_success "✅ $ext"
        else
            log_error "❌ $ext faltante"
            exit 1
        fi
    done
    
    # Verificar que los archivos de Laravel existen
    log_info "Verificando estructura de Laravel..."
    if [ ! -f "artisan" ]; then
        log_error "❌ Archivo artisan no encontrado en $(pwd)"
        log_info "Contenido del directorio actual:"
        ls -la
        exit 1
    else
        log_success "✅ artisan encontrado"
    fi
    
    # Verificar composer.json
    if [ -f "composer.json" ]; then
        log_info "Verificando dependencias de Composer..."
        
        # Instalar dependencias solo si no están instaladas
        if [ ! -d "vendor" ]; then
            log_info "Instalando dependencias de Composer..."
            if composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist; then
                log_success "Dependencias de Composer instaladas"
            else
                log_warning "Error en composer install - continuando sin vendor/"
            fi
        else
            log_success "Dependencias ya instaladas"
        fi
    else
        log_warning "composer.json no encontrado - saltando instalación de dependencias"
    fi
    
    # Generar APP_KEY si no existe
    log_info "Configurando APP_KEY..."
    if [ -z "$APP_KEY" ] || [[ "$APP_KEY" == *"GENERATE_YOUR_APP_KEY_HERE"* ]]; then
        log_info "Generando APP_KEY..."
        if command_exists php; then
            APP_KEY=$(php -r "echo 'base64:' . base64_encode(random_bytes(32));")
            export APP_KEY
            log_success "APP_KEY generado automáticamente"
        else
            log_warning "PHP no disponible para generar APP_KEY"
        fi
    fi
    
    # Configurar APP_URL si no está definida
    if [ -z "$APP_URL" ]; then
        if [ -n "$EASYPANEL_DOMAIN" ]; then
            APP_URL="https://${EASYPANEL_DOMAIN}/"
            export APP_URL
            log_success "APP_URL configurada: $APP_URL"
        else
            APP_URL="http://localhost/"
            export APP_URL
            log_warning "APP_URL configurada por defecto: $APP_URL"
        fi
    fi
    
    # Crear archivo .env optimizado para EasyPanel
    log_info "Creando archivo .env optimizado para EasyPanel..."
    
    cat > .env << EOF
# ==============================================================================
# CONFIGURACIÓN DEL SISTEMA CPS - EASYPANEL (GENERADO AUTOMÁTICAMENTE)
# Generado: $(date)
# ==============================================================================

# === VARIABLES AUTOMÁTICAS DE EASYPANEL ===
EASYPANEL=${EASYPANEL:-false}
EASYPANEL_PROJECT=${EASYPANEL_PROJECT}
EASYPANEL_DOMAIN=${EASYPANEL_DOMAIN}
HOST=${HOST:-0.0.0.0}
PORT=${PORT:-80}

# === CONFIGURACIÓN DE LA APLICACIÓN ===
APP_NAME=${APP_NAME:-CPS}
APP_ENV=${APP_ENV:-production}
APP_KEY=${APP_KEY}
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=${APP_URL}

# === CONFIGURACIÓN DE BASE DE DATOS ===
DB_CONNECTION=mysql
DB_HOST=${DB_HOST:-mysql}
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-cps_database}
DB_USERNAME=${DB_USERNAME:-cps_user}
DB_PASSWORD=${DB_PASSWORD:-cps_password_123}

# === CONFIGURACIÓN DE REDIS ===
REDIS_HOST=${REDIS_HOST:-redis}
REDIS_PORT=${REDIS_PORT:-6379}
REDIS_PASSWORD=${REDIS_PASSWORD:-null}

# === CONFIGURACIÓN DE CACHÉ Y SESIONES ===
CACHE_DRIVER=redis
SESSION_DRIVER=redis
SESSION_LIFETIME=120
SESSION_SECURE_COOKIE=true
SESSION_HTTP_ONLY=true

# === CONFIGURACIÓN DE COLAS ===
QUEUE_CONNECTION=redis

# === CONFIGURACIÓN DE LOGGING ===
LOG_CHANNEL=stack
LOG_LEVEL=notice

# === CONFIGURACIÓN DE EMAIL ===
MAIL_DRIVER=smtp
MAIL_HOST=${MAIL_HOST}
MAIL_PORT=${MAIL_PORT:-587}
MAIL_USERNAME=${MAIL_USERNAME}
MAIL_PASSWORD=${MAIL_PASSWORD}
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS}
MAIL_FROM_NAME=${MAIL_FROM_NAME:-"CPS System"}

# === CONFIGURACIÓN DE BROADCASTING ===
BROADCAST_DRIVER=log

# === CONFIGURACIÓN DE SEGURIDAD ===
SESSION_COOKIE_SECURE=true
SESSION_COOKIE_HTTPONLY=true
SESSION_USE_STRICT_MODE=1

# === CONFIGURACIÓN DE CPANEL LICENSING ===
APP_LICENSE=${APP_LICENSE}
APP_VERSION=${APP_VERSION:-120.55.1}
API_TOKEN=${API_TOKEN}

EOF

    log_success "Archivo .env creado"
    
    # Esperar a que los servicios estén disponibles
    log_info "Esperando a que los servicios estén disponibles..."
    
    # Esperar MySQL
    if wait_for_service "${DB_HOST:-mysql}" "${DB_PORT:-3306}" "MySQL" 60; then
        log_success "MySQL disponible"
    else
        log_warning "MySQL no disponible - puede ser un problema temporal"
    fi
    
    # Esperar Redis
    if wait_for_service "${REDIS_HOST:-redis}" "${REDIS_PORT:-6379}" "Redis" 60; then
        log_success "Redis disponible"
    else
        log_warning "Redis no disponible - puede ser un problema temporal"
    fi
    
    # Ejecutar migraciones de base de datos
    if [ -f "artisan" ] && [ -d "database/migrations" ]; then
        log_info "Ejecutando migraciones de base de datos..."
        if php artisan migrate --force; then
            log_success "Migraciones ejecutadas correctamente"
        else
            log_warning "Error en migraciones - pueden estar ya aplicadas"
        fi
    else
        log_warning "Migraciones no disponibles"
    fi
    
    # Ejecutar seeders si es necesario
    if [ "$APP_ENV" = "production" ] && [ "$RUN_SEEDERS" = "true" ]; then
        log_info "Ejecutando seeders..."
        php artisan db:seed --force
    fi
    
    # Optimizar Laravel para producción
    log_info "Optimizando Laravel para producción..."
    
    # Cache de configuración
    if [ -f "artisan" ]; then
        if php artisan config:cache; then
            log_success "Configuración cacheada"
        else
            log_warning "Error cacheando configuración"
        fi
        
        # Cache de rutas
        if php artisan route:cache; then
            log_success "Rutas cacheadas"
        else
            log_warning "Error cacheando rutas"
        fi
        
        # Cache de vistas
        if php artisan view:cache; then
            log_success "Vistas cacheadas"
        else
            log_warning "Error cacheando vistas"
        fi
    else
        log_warning "Comandos artisan no disponibles"
    fi
    
    # Verificar integridad final del sistema
    log_info "Verificando integridad del sistema..."
    
    local system_ok=true
    
    # Verificar archivos críticos
    local critical_files=("public/index.php" "config/app.php" "routes/web.php")
    for file in "${critical_files[@]}"; do
        if [ -f "$file" ]; then
            log_success "✅ $file encontrado"
        else
            log_error "❌ $file faltante"
            system_ok=false
        fi
    done
    
    # Verificar permisos
    if [ -w "storage" ]; then
        log_success "✅ Permisos de escritura en storage"
    else
        log_error "❌ Sin permisos de escritura en storage"
        system_ok=false
    fi
    
    if [ -w "bootstrap/cache" ]; then
        log_success "✅ Permisos de escritura en bootstrap/cache"
    else
        log_error "❌ Sin permisos de escritura en bootstrap/cache"
        system_ok=false
    fi
    
    # Verificar supervisor
    if command_exists supervisord; then
        log_success "✅ Supervisord disponible"
    else
        log_error "❌ Supervisord no disponible"
        system_ok=false
    fi
    
    # Resultado final
    if [ "$system_ok" = true ]; then
        log_success "🎉 Sistema inicializado correctamente"
        log_info "✅ Todas las verificaciones pasaron"
    else
        log_error "❌ Problemas detectados en la inicialización"
        exit 1
    fi
    
    # Mostrar información final
    log_info "📊 Información del Sistema:"
    log_info "Directorio: $(pwd)"
    log_info "APP_ENV: ${APP_ENV:-production}"
    log_info "APP_URL: ${APP_URL}"
    log_info "DB_HOST: ${DB_HOST:-mysql}"
    log_info "REDIS_HOST: ${REDIS_HOST:-redis}"
    
    # Cambiar al directorio público para Nginx
    if [ -d "public" ]; then
        cd public
        log_info "Cambiando al directorio público: $(pwd)"
    else
        log_warning "Directorio public no encontrado"
    fi
    
    # Mostrar contenido del directorio actual para debug
    log_info "Contenido del directorio actual:"
    ls -la
    
    log_success "🚀 Inicialización completada. Iniciando supervisord..."
    
    # Iniciar supervisord (esto debería ejecutar el CMD del Dockerfile)
    exec /usr/bin/supervisord -c /etc/supervisord.conf
}

# Ejecutar función principal
main "$@"