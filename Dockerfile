# Dockerfile para Sistema Laravel con PHP 8.3, ionCube 15.0.0 y MySQL
# CON VALIDACIÓN AUTOMÁTICA OPTIMIZADA PARA EASYPANEL
FROM php:8.3-fpm

# Argumentos de construcción para variables de entorno
ARG APP_NAME="CPS License Management"
ARG APP_ENV=production
ARG APP_KEY=""
ARG APP_DEBUG=false
ARG APP_URL="https://cps.qhosting.net"

# Base de datos
ARG DB_CONNECTION=mysql
ARG DB_HOST=127.0.0.1
ARG DB_PORT=3306
ARG DB_DATABASE=cps_database
ARG DB_USERNAME=username
ARG DB_PASSWORD=password

# Redis
ARG REDIS_HOST=127.0.0.1
ARG REDIS_PASSWORD=null
ARG REDIS_PORT=6379

# Configuración de correo
ARG MAIL_MAILER=smtp
ARG MAIL_HOST=mailhog
ARG MAIL_PORT=1025
ARG MAIL_USERNAME=null
ARG MAIL_PASSWORD=null
ARG MAIL_ENCRYPTION=null
ARG MAIL_FROM_ADDRESS="hello@example.com"
ARG MAIL_FROM_NAME="${APP_NAME}"

# Claves de pago
ARG STRIPE_KEY=your_stripe_public_key
ARG STRIPE_SECRET=your_stripe_secret_key
ARG PAYPAL_CLIENT_ID=your_paypal_client_id
ARG PAYPAL_CLIENT_SECRET=your_paypal_client_secret
ARG PAYPAL_MODE=sandbox

# Verificar y crear usuario www-data solo si no existe
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
    libmagickwand-dev \
    libwebp-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    netcat-openbsd \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Instalar extensiones de PHP
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

# Configurar ionCube en PHP usando ruta dinámica
RUN echo "zend_extension=$(php-config --extension-dir)/ioncube_loader_lin_8.3.so" > /usr/local/etc/php/conf.d/00-ioncube.ini

# Verificar que ionCube está instalado correctamente
RUN php -v

# Establecer directorio de trabajo
WORKDIR /var/www

# Copiar archivos de la aplicación
COPY system/ /var/www/

# Crear directorios necesarios con propiedad correcta ANTES de composer install
RUN mkdir -p /var/www/bootstrap/cache \
    && mkdir -p /var/www/storage/logs \
    && mkdir -p /var/www/storage/framework \
    && mkdir -p /var/www/storage/framework/cache \
    && mkdir -p /var/www/storage/framework/sessions \
    && mkdir -p /var/www/storage/framework/views \
    && mkdir -p /var/www/storage/app \
    && chown -R www-data:www-data /var/www \
    && chmod -R 777 /var/www/bootstrap/cache \
    && chmod -R 777 /var/www/storage/logs \
    && chmod -R 777 /var/www/storage/framework \
    && chmod -R 777 /var/www/storage/app

# Instalar dependencias de PHP con usuario correcto
RUN chown -R www-data:www-data /var/www \
    && sudo -u www-data composer install --optimize-autoloader --no-dev --no-interaction || \
    composer install --optimize-autoloader --no-dev --no-interaction

# Crear archivo .env directamente usando heredoc
RUN cat > /var/www/.env << EOF
APP_NAME="${APP_NAME}"
APP_ENV=${APP_ENV}
APP_KEY=${APP_KEY}
APP_DEBUG=${APP_DEBUG}
APP_URL=${APP_URL}

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=${DB_CONNECTION}
DB_HOST=${DB_HOST}
DB_PORT=${DB_PORT}
DB_DATABASE=${DB_DATABASE}
DB_USERNAME=${DB_USERNAME}
DB_PASSWORD=${DB_PASSWORD}

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DRIVER=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=${REDIS_HOST}
REDIS_PASSWORD=${REDIS_PASSWORD}
REDIS_PORT=${REDIS_PORT}

MAIL_MAILER=${MAIL_MAILER}
MAIL_HOST=${MAIL_HOST}
MAIL_PORT=${MAIL_PORT}
MAIL_USERNAME=${MAIL_USERNAME}
MAIL_PASSWORD=${MAIL_PASSWORD}
MAIL_ENCRYPTION=${MAIL_ENCRYPTION}
MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS}
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_APP_CLUSTER=mt1

MIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
MIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"

STRIPE_KEY=${STRIPE_KEY}
STRIPE_SECRET=${STRIPE_SECRET}
PAYPAL_CLIENT_ID=${PAYPAL_CLIENT_ID}
PAYPAL_CLIENT_SECRET=${PAYPAL_CLIENT_SECRET}
PAYPAL_MODE=${PAYPAL_MODE}
EOF

# Configurar permisos finales para producción
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 777 /var/www/bootstrap/cache \
    && chmod -R 777 /var/www/storage/logs \
    && chmod -R 777 /var/www/storage/framework \
    && chmod -R 777 /var/www/storage/app

# ===============================
# VALIDACIÓN AUTOMÁTICA PARA EASYPANEL
# ===============================

# Copiar scripts de validación
RUN mkdir -p /var/www/validation-scripts
COPY validation-scripts/ /var/www/validation-scripts/

# Hacer ejecutables los scripts de validación
RUN chmod +x /var/www/validation-scripts/*.sh

# Ejecutar validación automática optimizada para build
RUN echo "" && \
    echo "========================================" && \
    echo "=== EASYPANEL POST-DEPLOY VALIDATION ===" && \
    echo "===    Validación de Build Docker      ===" && \
    echo "========================================" && \
    cd /var/www/validation-scripts && \
    bash docker_build_validation.sh && \
    echo "" && \
    echo "=== VALIDACIÓN DE BUILD COMPLETADA ===" && \
    echo "✅ Contenedor listo para despliegue" && \
    echo "🔄 La validación completa se ejecutará al iniciar" && \
    cd /var/www

# Comando de inicio por defecto
CMD ["sh", "-c", "php-fpm && nginx -g 'daemon off;'"]