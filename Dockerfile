# Dockerfile para Sistema Laravel con PHP 8.3, ionCube y MySQL
FROM php:8.3-fpm

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

# Configurar ionCube Loader
RUN curl -L -o /tmp/ioncube.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar xzf /tmp/ioncube.tar.gz \
    && mkdir -p /usr/local/lib/php/extensions/no-debug-non-zts-20230831 \
    && cp ioncube/ioncube_loader_lin_8.3.so /usr/local/lib/php/extensions/no-debug-non-zts-20230831/ \
    && rm -rf ioncube /tmp/ioncube.tar.gz

# Configurar ionCube en PHP
RUN echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20230831/ioncube_loader_lin_8.3.so" > /usr/local/etc/php/conf.d/00-ioncube.ini

# Verificar que ionCube está instalado correctamente
RUN php -v

# Establecer directorio de trabajo
WORKDIR /var/www

# Copiar archivos de la aplicación
COPY system/ /var/www/

# Instalar dependencias de PHP (solo después de verificar ionCube)
RUN composer install --optimize-autoloader --no-dev --no-interaction

# Configurar permisos
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage \
    && chmod -R 777 /var/www/storage/logs \
    && chmod -R 777 /var/www/storage/framework \
    && chmod -R 777 /var/www/storage/app \
    && chmod -R 777 /var/www/bootstrap/cache

# Comando de inicio por defecto
CMD ["php-fpm"]
CMD ["sh", "-c", "php-fpm && nginx -g 'daemon off;'"]