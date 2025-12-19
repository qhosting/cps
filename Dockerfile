# Dockerfile optimizado para EasyPanel - Puerto 3000
# Sistema CPS - Gestión de Licencias con Laravel + PHP 8.3 + ionCube

FROM php:8.3-fpm

# Argumentos de construcción
ARG APP_NAME="CPS License Management"
ARG APP_ENV=production
ARG APP_DEBUG=false
ARG APP_URL="https://tu-dominio.com"
ARG PORT=3000

# Base de datos y cache
ARG DB_HOST=localhost
ARG DB_DATABASE=cps_database
ARG DB_USERNAME=cps_user
ARG DB_PASSWORD=cps_secure_2025
ARG REDIS_HOST=localhost
ARG REDIS_PORT=6379

# Configuración de correo y pagos
ARG MAIL_MAILER=smtp
ARG MAIL_HOST=localhost
ARG MAIL_PORT=25
ARG MAIL_USERNAME=
ARG MAIL_PASSWORD=
ARG STRIPE_KEY=your_stripe_key
ARG STRIPE_SECRET=your_stripe_secret

# Instalar usuario www-data
RUN (getent group www-data >/dev/null 2>&1) || groupadd -g 33 www-data && \
    (id -u www-data >/dev/null 2>&1) || useradd -u 33 -g www-data www-data

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libwebp-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    netcat-openbsd \
    procps \
    nginx \
    gettext-base \
    supervisor \
    mariadb-client-compat \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

# Instalar extensiones PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar ionCube Loader 15.0.0 para PHP 8.3
RUN curl -L -o /tmp/ioncube.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar xzf /tmp/ioncube.tar.gz \
    && PHP_EXT_DIR=$(php-config --extension-dir) \
    && mkdir -p $PHP_EXT_DIR \
    && cp ioncube/ioncube_loader_lin_8.3.so $PHP_EXT_DIR/ \
    && rm -rf ioncube /tmp/ioncube.tar.gz

# Configurar ionCube
RUN echo "zend_extension=$(php-config --extension-dir)/ioncube_loader_lin_8.3.so" > /usr/local/etc/php/conf.d/00-ioncube.ini

# Establecer directorio de trabajo
WORKDIR /var/www

# Copiar código fuente
COPY system/ /var/www/

# Crear directorios necesarios
RUN mkdir -p /var/www/bootstrap/cache \
    && mkdir -p /var/www/storage/logs \
    && mkdir -p /var/www/storage/framework/cache \
    && mkdir -p /var/www/storage/framework/sessions \
    && mkdir -p /var/www/storage/framework/views \
    && mkdir -p /var/www/storage/app \
    && chown -R www-data:www-data /var/www \
    && chmod -R 777 /var/www/bootstrap/cache \
    && chmod -R 777 /var/www/storage

# Instalar dependencias Composer
RUN chown -R www-data:www-data /var/www \
    && sudo -u www-data composer install --optimize-autoloader --no-dev --no-interaction || \
    composer install --optimize-autoloader --no-dev --no-interaction

# Crear archivo .env
RUN cat > /var/www/.env << EOF
APP_NAME="${APP_NAME}"
APP_ENV=${APP_ENV}
APP_KEY=
APP_DEBUG=${APP_DEBUG}
APP_URL=${APP_URL}
APP_PORT=${PORT}

LOG_CHANNEL=stack
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=${DB_HOST}
DB_PORT=3306
DB_DATABASE=${DB_DATABASE}
DB_USERNAME=${DB_USERNAME}
DB_PASSWORD=${DB_PASSWORD}

CACHE_DRIVER=redis
FILESYSTEM_DRIVER=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=redis
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=${REDIS_HOST}
REDIS_PASSWORD=null
REDIS_PORT=${REDIS_PORT}

MAIL_MAILER=${MAIL_MAILER}
MAIL_HOST=${MAIL_HOST}
MAIL_PORT=${MAIL_PORT}
MAIL_USERNAME=${MAIL_USERNAME}
MAIL_PASSWORD=${MAIL_PASSWORD}
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="noreply@tu-dominio.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

STRIPE_KEY=${STRIPE_KEY}
STRIPE_SECRET=${STRIPE_SECRET}
EOF

# Configurar permisos
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 777 /var/www/bootstrap/cache

# Configurar Nginx para puerto 3000
COPY nginx.conf /etc/nginx/nginx.conf

# Configurar Supervisor para manejar PHP-FPM y Nginx
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copiar scripts de inicio
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Exponer puerto 3000
EXPOSE 3000

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:3000/ || exit 1

# Script de inicio
CMD ["/usr/local/bin/start.sh"]