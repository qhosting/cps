# Dockerfile para Sistema Laravel con PHP 8.3, ionCube 15.0.0 y MySQL
FROM php:8.3-fpm

# Crear usuario www-data ANTES de cualquier operación
RUN groupadd -g 33 www-data && \
    useradd -u 33 -g www-data www-data

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

# Configurar permisos finales para producción
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 777 /var/www/bootstrap/cache \
    && chmod -R 777 /var/www/storage/logs \
    && chmod -R 777 /var/www/storage/framework \
    && chmod -R 777 /var/www/storage/app

# Comando de inicio por defecto
CMD ["sh", "-c", "php-fpm && nginx -g 'daemon off;'"]