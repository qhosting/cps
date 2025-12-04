# ==============================================================================
# DOCKERFILE ALL-IN-ONE PARA EASYPANEL - SISTEMA CPS
# 
# Este Dockerfile incluye TODO en un solo contenedor:
# - PHP 8.1 + FPM
# - Nginx
# - MySQL 8.0
# - Redis
# - ionCube Loader
# - Laravel Queue Worker
# - Laravel Scheduler
# ==============================================================================

FROM php:8.1-fpm-alpine

LABEL maintainer="Matrix Agent" 
LABEL description="CPS System All-in-One para EasyPanel"
LABEL version="2.0.0-allinone"

# Variables de entorno para MySQL
ENV MYSQL_ROOT_PASSWORD=cps_root_password
ENV MYSQL_DATABASE=cps_database
ENV MYSQL_USER=cps_user
ENV MYSQL_PASSWORD=cps_password_123

# Actualizar sistema e instalar TODAS las dependencias
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
    # Bibliotecas adicionales
    gmp-dev \
    # ===== SERVICIOS ALL-IN-ONE =====
    # Supervisor para gestionar todos los procesos
    supervisor \
    # Nginx como servidor web
    nginx \
    # Redis para caché y sesiones
    redis \
    # MariaDB (compatible MySQL) - más ligero que MySQL oficial
    mariadb mariadb-client mariadb-common \
    # Netcat para verificación de conectividad
    netcat-openbsd \
    # Herramientas adicionales
    patchelf tzdata && \
    rm -rf /var/cache/apk/*

# Configurar timezone
RUN cp /usr/share/zoneinfo/UTC /etc/localtime && \
    echo "UTC" > /etc/timezone

# Instalar extensiones PHP
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

# Instalar ionCube Loader
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
    mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/log/redis && \
    mkdir -p /run/mysqld && \
    mkdir -p /run/nginx && \
    chown -R mysql:mysql /var/lib/mysql /var/log/mysql /run/mysqld && \
    chown -R app:app /var/www && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 755 /var/www

# Directorio de trabajo
WORKDIR /var/www

# Copiar configuraciones PHP
COPY php.ini /usr/local/etc/php/php.ini
COPY docker/php.ini /usr/local/etc/php/conf.d/99-custom.ini

# Copiar archivos de la aplicación
COPY composer.json composer.lock ./

# Instalar dependencias de Composer
RUN if [ -f "composer.json" ]; then \
        composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist || true; \
    fi

# Verificar ionCube
RUN php -v

# Copiar todo el código
COPY . .

# Copiar configuraciones all-in-one
COPY docker/supervisord-allinone.conf /etc/supervisord.conf
COPY docker/nginx-allinone.conf /etc/nginx/http.d/default.conf
COPY docker/entrypoint-allinone.sh /entrypoint.sh

# Hacer ejecutables los scripts
RUN chmod +x /entrypoint.sh

# Configurar permisos finales
RUN chown -R app:app /var/www && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 755 /var/www/public

# Exponer puerto 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Punto de entrada
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

# Comando por defecto
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
