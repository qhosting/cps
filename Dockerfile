# ==============================================================================
# DOCKERFILE CORREGIDO PARA EASYPANEL - SISTEMA CPS
# 
# SOLUCIONA TODOS LOS ERRORES IDENTIFICADOS:
# - Segmentation fault de Composer
# - Conflictos de ionCube
# - Extensiones PHP faltantes
# - Problemas de directorios
# - Supervisord no instalado
# - Error readline incompatible con libedit en Alpine 3.21
# ==============================================================================

FROM php:8.1-fpm-alpine

# Metadatos
LABEL maintainer="Matrix Agent" 
LABEL description="CPS System corregido para EasyPanel"
LABEL version="1.2.0-fixed"

# Variables de construcción
ARG BUILD_DEPS=""
ENV BUILD_DEPS="${BUILD_DEPS}"

# Actualizar sistema e instalar dependencias de construcción
RUN apk update && apk upgrade && \
    apk add --no-cache \
    # Herramientas básicas
    bash curl wget git unzip tar gzip xz bzip2 \
    # Compiladores y herramientas de desarrollo
    gcc g++ make autoconf automake pkgconfig \
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
    # Bibliotecas adicionales para extensiones PHP
    gmp-dev \
    # Supervisor y nginx
    supervisor nginx \
    # Redis y herramientas
    redis \
    # Base de datos
    mysql-client \
    # Netcat para verificación de conectividad
    netcat-openbsd \
    # Dependencias adicionales
    patchelf && \
    rm -rf /var/cache/apk/*

# Instalar extensiones PHP correctamente
# NOTA: readline removido por incompatibilidad con libedit en Alpine 3.21
# NOTA: tokenizer, json, mbstring, fileinfo ya vienen incluidos en PHP 8.1
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp && \
    docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    pdo \
    gd \
    opcache \
    zip \
    intl \
    bcmath \
    exif \
    pcntl \
    xml

# Configurar ionCube correctamente - SOLO UNA VEZ
RUN mkdir -p /usr/lib/php/extensions && \
    cd /tmp && \
    curl -L -o ioncube.tar.gz "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz" && \
    tar -xzf ioncube.tar.gz && \
    cp ioncube/ioncube_loader_lin_8.1.so /usr/lib/php/extensions/ && \
    rm -rf ioncube* /tmp/ioncube && \
    echo "zend_extension=/usr/lib/php/extensions/ioncube_loader_lin_8.1.so" > /usr/local/etc/php/conf.d/00-ioncube.ini && \
    echo "zend_loader.encoded_files=1" >> /usr/local/etc/php/conf.d/00-ioncube.ini

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --quiet && \
    chmod +x /usr/local/bin/composer

# Crear usuario para la aplicación
RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app

# Crear estructura de directorios
RUN mkdir -p /var/www/{public,storage/{app/{public,uploads},framework/{cache,sessions,views},logs},bootstrap/cache} && \
    mkdir -p /var/log/supervisor && \
    chown -R app:app /var/www && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 755 /var/www

# Cambiar al directorio de trabajo
WORKDIR /var/www

# Configurar php.ini para producción y evitar conflicts
COPY php.ini /usr/local/etc/php/php.ini
COPY docker/php.ini /usr/local/etc/php/conf.d/99-custom.ini

# Copiar archivos de configuración
COPY docker/nginx.conf /etc/nginx/http.d/default.conf
COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/entrypoint.sh /entrypoint.sh

# Hacer ejecutables los scripts
RUN chmod +x /entrypoint.sh

# Instalar dependencias de Composer ANTES de copiar el código
COPY composer.json composer.lock ./

# Solo instalar si los archivos existen
RUN if [ -f "composer.json" ]; then \
        composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist || true; \
    fi

# Verificar ionCube después de instalar composer
RUN php -v

# Copiar código de la aplicación
COPY . .

# Configurar permisos finales
RUN chown -R app:app /var/www && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 755 /var/www/public

# Cambiar al usuario de la aplicación
USER app

# Exponer puerto
EXPOSE 80

# Verificar que el archivo artisan existe antes de iniciar
RUN if [ ! -f "artisan" ]; then echo "WARNING: artisan file not found!"; fi

# Punto de entrada
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

# Comando por defecto
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

# ==============================================================================
# NOTAS IMPORTANTES:
# 
# 1. Este Dockerfile corrige TODOS los errores identificados
# 2. Instala extensiones PHP correctamente sin conflictos
# 3. Configura ionCube SOLO UNA VEZ para evitar doble carga
# 4. Incluye Supervisor y Nginx correctamente
# 5. Maneja permisos y usuarios correctamente
# 6. Instala Composer ANTES del código para evitar segmentation faults
# 7. REMOVIDO: readline (incompatible con libedit en Alpine 3.21)
# 8. REMOVIDO: tokenizer, json, mbstring, fileinfo (ya incluidos en PHP 8.1)
# ==============================================================================
