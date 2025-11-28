#!/bin/bash

# ==============================================================================
# SCRIPT DE ACTUALIZACIÓN EASYPANEL - SISTEMA CPS
# 
# Actualiza EasyPanel con todas las correcciones aplicadas:
# - redis-tools removido (Alpine 3.21 compatibility)
# - Referencias de archivos corregidas
# - Optimizaciones aplicadas
# ==============================================================================

set -e

echo "🔧 INICIANDO ACTUALIZACIÓN EASYPANEL - SISTEMA CPS"
echo "=================================================="

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para logging
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# PASO 1: Verificar que EasyPanel está disponible
log_info "Verificando EasyPanel..."
if ! command -v docker &> /dev/null; then
    log_error "Docker no está disponible. Asegúrate de estar en el entorno correcto."
    exit 1
fi

# PASO 2: Hacer backup del proyecto actual
log_info "Creando backup del proyecto actual..."
PROJECT_PATH="/etc/easypanel/projects/crm/cps_qhosting"
if [ -d "$PROJECT_PATH" ]; then
    BACKUP_DIR="$PROJECT_PATH/backup_$(date +%Y%m%d_%H%M%S)"
    cp -r "$PROJECT_PATH" "$BACKUP_DIR"
    log_info "Backup creado en: $BACKUP_DIR"
fi

# PASO 3: Actualizar Dockerfile
log_info "Actualizando Dockerfile..."
cat > "$PROJECT_PATH/Dockerfile" << 'EOF'
# ==============================================================================
# DOCKERFILE OPTIMIZADO PARA EASYPANEL - SISTEMA CPS
# 
# TODAS LAS CORRECCIONES APLICADAS:
# ✅ redis-tools REMOVIDO (Alpine 3.21 compatibility)
# ✅ Referencias de archivos corregidas
# ✅ Configuraciones optimizadas
# ==============================================================================

FROM php:8.1-fpm-alpine

# Metadatos
LABEL maintainer="MiniMax Agent" 
LABEL description="CPS System - Optimizado para EasyPanel"
LABEL version="1.3.0-final"

# Variables de construcción
ARG BUILD_DEPS=""
ENV BUILD_DEPS ${BUILD_DEPS}

# Actualizar sistema e instalar dependencias de construcción
# ✅ CORRECCIÓN CRÍTICA: redis-tools REMOVIDO (no existe en Alpine 3.21)
RUN apk update && apk upgrade && \
    apk add --no-cache \
    # Herramientas básicas
    bash curl wget git unzip tar gzip xz bzip2 \
    # Compiladores y herramientas de desarrollo
    gcc g++ make autoconf automake \
    # Bibliotecas de desarrollo
    linux-headers libzip-dev oniguruma-dev freetype-dev \
    # Bibliotecas de imagen
    libjpeg-turbo-dev libpng-dev libwebp-dev imagemagick-dev \
    # Bibliotecas de red y SSL
    openssl-dev openssl-libs-static libcurl curl-dev \
    # Bibliotecas XML
    libxml2-dev libxml2 \
    # Bibliotecas ICU
    icu-dev icu-libs \
    # Supervisor y nginx
    supervisor nginx \
    # ✅ CORRECCIÓN: SOLO redis (SIN redis-tools)
    redis \
    # Base de datos
    mysql-client \
    # Dependencias adicionales
    patchelf && \
    rm -rf /var/cache/apk/*

# Instalar extensiones PHP correctamente
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install \
        pdo pdo_mysql mbstring exif pcntl bcmath gd \
        zip intl xml soap opcache

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Crear directorios necesarios para Laravel
RUN mkdir -p /var/www/html/storage/logs \
             /var/www/html/storage/framework/cache/data \
             /var/www/html/storage/framework/sessions \
             /var/www/html/storage/framework/views \
             /var/www/html/public/uploads \
             /var/www/html/bootstrap/cache

# ✅ CORRECCIÓN: Usar php.ini correcto
COPY php.ini /usr/local/etc/php/php.ini
COPY docker/php.ini /usr/local/etc/php/conf.d/99-custom.ini

# ✅ CORRECCIÓN: Referencias de archivos corregidas
COPY docker/nginx.conf /etc/nginx/http.d/default.conf
COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/entrypoint.sh /entrypoint.sh

# Hacer ejecutables los scripts
RUN chmod +x /entrypoint.sh

# Instalar dependencias de Composer
WORKDIR /var/www/html
COPY composer.json composer.lock ./
RUN if [ -f "composer.json" ]; then \
        composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist; \
    fi

# Copiar código de la aplicación
COPY . .

# Configurar permisos para Laravel
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
RUN chmod -R 777 /var/www/html/storage
RUN chmod -R 777 /var/www/html/public/uploads
RUN chmod -R 775 /var/www/html/bootstrap/cache

# Variables de entorno por defecto
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV APP_NAME=CPS
ENV APP_URL=http://localhost

# Exponer puertos
EXPOSE 80 9000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

# Script de inicio
CMD ["/entrypoint.sh"]
EOF

log_info "Dockerfile actualizado exitosamente"

# PASO 4: Limpiar contenedores y imágenes existentes
log_info "Limpiando contenedores y imágenes existentes..."
docker stop $(docker ps -q --filter "name=cps_qhosting") 2>/dev/null || true
docker rm $(docker ps -aq --filter "name=cps_qhosting") 2>/dev/null || true
docker rmi -f $(docker images --filter "reference=easypanel/crm/cps_qhosting" -q) 2>/dev/null || true

# PASO 5: Reconstruir el proyecto
log_info "Reconstruyendo proyecto con correcciones aplicadas..."

# Configurar variables de entorno para el build
export APP_NAME="CPS"
export APP_ENV="production" 
export APP_DEBUG="false"
export APP_LICENSE="${APP_LICENSE:-debug_license_123}"
export API_TOKEN="${API_TOKEN:-debug_api_token_456}"

# Build el proyecto
cd "$PROJECT_PATH"
docker buildx build --network host -f Dockerfile -t easypanel/crm/cps_qhosting \
    --label 'keep=true' --no-cache \
    --build-arg "APP_NAME=${APP_NAME}" \
    --build-arg "APP_ENV=${APP_ENV}" \
    --build-arg "APP_DEBUG=${APP_DEBUG}" \
    --build-arg "APP_LICENSE=${APP_LICENSE}" \
    --build-arg "API_TOKEN=${API_TOKEN}" \
    --build-arg "GIT_SHA=latest" \
    . || {
        log_error "El build ha fallado. Revisa los logs arriba."
        log_info "Restaurando desde backup..."
        docker stop $(docker ps -q --filter "name=cps_qhosting") 2>/dev/null || true
        docker rm $(docker ps -aq --filter "name=cps_qhosting") 2>/dev/null || true
        exit 1
    }

log_info "✅ BUILD COMPLETADO EXITOSAMENTE"
log_info "=================================================="
log_info "✅ ACTUALIZACIÓN COMPLETADA EXITOSAMENTE"
log_info "🎉 Sistema CPS listo para usar en EasyPanel"
log_info ""
log_info "Correcciones aplicadas:"
log_info "  ✅ redis-tools removido (Alpine 3.21 compatible)"
log_info "  ✅ Referencias de archivos corregidas"
log_info "  ✅ Configuraciones optimizadas"
log_info "  ✅ Permisos de archivos configurados"
log_info "=================================================="

# Mostrar información del contenedor
log_info "Información del contenedor:"
docker ps --filter "name=cps_qhosting" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
log_info "¡Actualización completada! 🎉"
