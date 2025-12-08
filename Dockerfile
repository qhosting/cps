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
    && cp ioncube/ioncube_loader_lin_8.3.so /usr/local/lib/php/extensions/ \
    && rm -rf ioncube /tmp/ioncube.tar.gz

# Configurar ionCube en PHP
RUN echo "zend_extension=ioncube_loader_lin_8.3.so" > /usr/local/etc/php/conf.d/00-ioncube.ini

# Establecer directorio de trabajo
WORKDIR /var/www

# Copiar archivos de la aplicación
COPY system/ /var/www/

# Instalar dependencias de PHP
RUN composer install --optimize-autoloader --no-dev --no-interaction

# Instalar dependencias de Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install \
    && npm run build

# Configurar permisos
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage \
    && chmod -R 777 /var/www/storage/logs \
    && chmod -R 777 /var/www/storage/framework \
    && chmod -R 777 /var/www/storage/app \
    && chmod -R 777 /var/www/bootstrap/cache

# Configurar Nginx
RUN apt-get update && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

# Copiar configuración de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copiar configuración PHP personalizada
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Exponer puerto
EXPOSE 80

# Comando de inicio
CMD ["sh", "-c", "php-fpm && nginx -g 'daemon off;'"]