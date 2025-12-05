# ==============================================================================
# DOCKERFILE ALL-IN-ONE PARA EASYPANEL - SISTEMA CPS
# 
# Este Dockerfile incluye TODO en un solo contenedor:
# - PHP 8.3 + FPM (ACTUALIZADO - requerido por archivos ionCube)
# - Nginx
# - MariaDB (MySQL compatible)
# - Redis
# - ionCube Loader
# - Laravel Queue Worker
# - Laravel Scheduler
#
# IMPORTANTE: Usa Debian (glibc) en lugar de Alpine (musl) 
# porque ionCube NO soporta musl/Alpine Linux
#
# NOTA: Los archivos helpers.php fueron encriptados para PHP 8.3
# ==============================================================================

FROM php:8.3-fpm-bookworm

LABEL maintainer="Matrix Agent" 
LABEL description="CPS System All-in-One para EasyPanel"
LABEL version="3.3.0-php83-ioncube-fix"

# Evitar prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Variables de entorno para MySQL
ENV MYSQL_ROOT_PASSWORD=cps_root_password
ENV MYSQL_DATABASE=cps_database
ENV MYSQL_USER=cps_user
ENV MYSQL_PASSWORD=cps_password_123

# Actualizar sistema e instalar TODAS las dependencias
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    # Herramientas básicas
    bash curl wget git unzip tar gzip xz-utils bzip2 ca-certificates \
    # Compiladores y herramientas de desarrollo
    gcc g++ make autoconf automake pkg-config \
    # Bibliotecas de desarrollo
    libzip-dev libonig-dev libfreetype6-dev \
    # Bibliotecas de imagen
    libjpeg62-turbo-dev libpng-dev libwebp-dev libmagickwand-dev \
    # Bibliotecas de red y SSL
    libssl-dev libcurl4-openssl-dev \
    # Bibliotecas XML
    libxml2-dev libxml2 \
    # Bibliotecas ICU
    libicu-dev \
    # Bibliotecas adicionales
    libgmp-dev \
    # ===== SERVICIOS ALL-IN-ONE =====
    # Supervisor para gestionar todos los procesos
    supervisor \
    # Nginx como servidor web
    nginx \
    # Redis para caché y sesiones
    redis-server \
    # MariaDB (compatible MySQL)
    mariadb-server mariadb-client \
    # Netcat para verificación de conectividad
    netcat-openbsd \
    # Procps para gestión de procesos
    procps \
    # Herramientas adicionales
    tzdata && \
    # Limpiar cache de apt
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configurar timezone
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo "UTC" > /etc/timezone

# Instalar extensiones PHP
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

# Instalar extensión Redis para PHP
RUN pecl install redis && \
    docker-php-ext-enable redis

# Instalar ionCube Loader para PHP 8.3 (versión para Linux glibc x86-64)
RUN PHP_EXT_DIR=$(php -r "echo ini_get('extension_dir');") && \
    echo "PHP Extension Directory: $PHP_EXT_DIR" && \
    cd /tmp && \
    curl -L -o ioncube.tar.gz "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz" && \
    tar -xzf ioncube.tar.gz && \
    cp ioncube/ioncube_loader_lin_8.3.so "$PHP_EXT_DIR/" && \
    rm -rf ioncube* && \
    echo "zend_extension=ioncube_loader_lin_8.3.so" > /usr/local/etc/php/conf.d/00-ioncube.ini

# Instalar Composer
RUN curl -sS https://getcomposer.org/download/latest-2.x/composer.phar -o /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

# Crear usuario para la aplicación
RUN groupadd -g 1000 app && \
    useradd -u 1000 -g app -m -s /bin/bash app

# Crear estructura de directorios
RUN mkdir -p /var/www/public && \
    mkdir -p /var/www/storage/app/public && \
    mkdir -p /var/www/storage/app/uploads && \
    mkdir -p /var/www/storage/framework/cache && \
    mkdir -p /var/www/storage/framework/sessions && \
    mkdir -p /var/www/storage/framework/views && \
    mkdir -p /var/www/storage/logs && \
    mkdir -p /var/www/bootstrap/cache && \
    mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/log/redis && \
    mkdir -p /run/mysqld && \
    mkdir -p /run/nginx && \
    mkdir -p /run/php && \
    chown -R mysql:mysql /var/lib/mysql /var/log/mysql /run/mysqld && \
    chown -R app:app /var/www && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 755 /var/www

# Directorio de trabajo
WORKDIR /var/www

# Copiar configuraciones PHP
COPY php.ini /usr/local/etc/php/php.ini
COPY docker/php.ini /usr/local/etc/php/conf.d/99-custom.ini

# ==============================================================================
# COMPOSER INSTALL - SOLUCION PARA IONCUBE
# ==============================================================================
# 1. Primero copiamos TODO el código (necesario para que composer pueda resolver)
# 2. Ejecutamos composer install SIN scripts (evita ejecutar artisan durante build)
# 3. Luego generamos el autoloader optimizado
# ==============================================================================

# Copiar todo el código primero
COPY . .

# Verificar ionCube está funcionando
RUN echo "=== Verificando ionCube ===" && \
    php -v && \
    php -m | grep -i ioncube && \
    echo "=== ionCube OK ==="

# Instalar dependencias de Composer SIN SCRIPTS
# --no-scripts: Evita ejecutar 'php artisan package:discover' que falla sin DB
# --no-dev: No instalar dependencias de desarrollo
# --optimize-autoloader: Optimizar el autoloader
RUN echo "=== Instalando dependencias de Composer ===" && \
    composer install \
        --no-dev \
        --no-scripts \
        --no-interaction \
        --prefer-dist \
        --optimize-autoloader \
        --ignore-platform-reqs && \
    echo "=== Composer install completado ===" && \
    ls -la vendor/ && \
    echo "=== vendor/autoload.php existe: ===" && \
    ls -la vendor/autoload.php

# Verificar que vendor existe
RUN if [ ! -f "vendor/autoload.php" ]; then \
        echo "ERROR: vendor/autoload.php NO EXISTE!" && exit 1; \
    else \
        echo "OK: vendor/autoload.php existe"; \
    fi

# Copiar configuraciones all-in-one
COPY docker/supervisord-allinone.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/nginx-allinone.conf /etc/nginx/sites-available/default
COPY docker/entrypoint-allinone.sh /entrypoint.sh

# Configurar Nginx para Debian
RUN rm -f /etc/nginx/sites-enabled/default && \
    ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Hacer ejecutables los scripts
RUN chmod +x /entrypoint.sh

# Configurar permisos finales
RUN chown -R app:app /var/www && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache && \
    chmod -R 755 /var/www/public

# Exponer puerto 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Punto de entrada
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

# Comando por defecto
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
