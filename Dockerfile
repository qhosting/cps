# Dockerfile para CPS Laravel
FROM php:8.1-fpm-alpine

# Instalar dependencias del sistema
RUN apk add --no-cache \
    bash \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libzip-dev \
    icu-dev \
    icu-libs \
    freetype-dev

# Instalar ionCube Loader
RUN curl -o ioncube.tar.gz http://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xzf ioncube.tar.gz \
    && cp ioncube/ioncube_loader_lin_8.1.so /usr/local/lib/php/extensions/ \
    && rm -rf ioncube* \
    && echo "zend_extension=/usr/local/lib/php/extensions/ioncube_loader_lin_8.1.so" > /usr/local/etc/php/conf.d/00-ioncube-loader.ini

# Instalar Composer
COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

# Configurar directorio de trabajo
WORKDIR /var/www

# Copiar archivos PHP y configurar
COPY docker/php.ini /usr/local/etc/php/php.ini
COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/entrypoint.sh /entrypoint.sh

# Instalar extensiones PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd intl zip

# Crear usuario para Laravel
RUN addgroup -g 1000 -S www && \
    adduser -u 1000 -S www -G www

# Configurar permisos
RUN chown -R www:www /var/www && \
    chown -R www:www /etc/nginx && \
    chmod +x /entrypoint.sh

USER www

EXPOSE 80

CMD ["/entrypoint.sh"]