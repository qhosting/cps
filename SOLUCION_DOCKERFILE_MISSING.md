# SOLUCIÓN: ELIMINAR ERROR "DOCKERFILE NOT FOUND"

## 🔍 DIAGNÓSTICO DEL PROBLEMA

El error que ves:
```
ERROR: failed to read dockerfile: open Dockerfile: no such file or directory
```

**Causa:** Tu repositorio en GitHub (`qhosting/cps`) no contiene los archivos Docker que necesitamos.

## ✅ SOLUCIÓN COMPLETA

### PASO 1: Agregar Archivos Docker al Repositorio

Necesitas agregar estos archivos a tu repositorio. Aquí están todos los archivos que debes crear:

#### 1. Dockerfile
Crea un archivo llamado `Dockerfile` en la raíz de tu repositorio con este contenido:

```dockerfile
# Imagen base optimizada para Laravel 9.x + ionCube
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
```

#### 2. docker-compose.yml
Crea un archivo llamado `docker-compose.yml` en la raíz:

```yaml
version: '3.8'

services:
  app:
    build: .
    container_name: cps_app
    ports:
      - "80:80"
    volumes:
      - ./:/var/www
    environment:
      - APP_ENV=production
    depends_on:
      - mysql
      - redis
    networks:
      - cps_network

  mysql:
    image: mysql:8.0
    container_name: cps_mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword123
      MYSQL_DATABASE: cps_database
      MYSQL_USER: cps_user
      MYSQL_PASSWORD: cps_password_123
    volumes:
      - mysql_data:/var/lib/mysql
    ports:
      - "3306:3306"
    networks:
      - cps_network

  redis:
    image: redis:7-alpine
    container_name: cps_redis
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"
    networks:
      - cps_network

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: cps_phpmyadmin
    environment:
      PMA_HOST: mysql
      PMA_PORT: 3306
    ports:
      - "8080:80"
    depends_on:
      - mysql
    networks:
      - cps_network

  redis-insight:
    image: redislabs/redisinsight:latest
    container_name: cps_redis_insight
    ports:
      - "8001:8001"
    volumes:
      - redis_insight_data:/db
    networks:
      - cps_network

networks:
  cps_network:
    driver: bridge

volumes:
  mysql_data:
  redis_data:
  redis_insight_data:
```

### PASO 2: Crear Directorio y Archivos Docker

#### 3. Crear carpeta `docker/` y estos archivos:

**3.1 docker/php.ini:**
```ini
[PHP]
engine = On
short_open_tag = Off
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = -1
disable_functions =
disable_classes =
zend.enable_gc = On
zend.exception_ignore_args = On
expose_php = Off

max_execution_time = 30
max_input_time = 60
memory_limit = 256M
error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
display_errors = Off
display_startup_errors = Off
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = Off
ignore_repeated_source = Off
post_max_size = 50M
default_mimetype = "text/html"
default_charset = "UTF-8"

; Configuración de ionCube
zend_extension=/usr/local/lib/php/extensions/ioncube_loader_lin_8.1.so

; Extensiones Laravel
extension=pdo_mysql
extension=mbstring
extension=openssl
extension=curl
extension=xml
extension=gd
extension=zip
extension=bcmath
```

**3.2 docker/nginx.conf:**
```nginx
user www;
worker_processes auto;
error_log /var/log/nginx/error.log warn;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name _;
        root /var/www/public;
        index index.php index.html index.htm;

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
            fastcgi_pass 127.0.0.1:9000;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
            include fastcgi_params;
        }

        location ~ /\.ht {
            deny all;
        }

        location ~* \.(jpg|jpeg|png|gif|ico|css|js|woff|woff2|ttf|svg)$ {
            expires 1y;
            add_header Cache-Control "public, immutable";
        }
    }
}
```

**3.3 docker/supervisord.conf:**
```ini
[supervisord]
nodaemon=true
user=root

[program:nginx]
command=nginx -g 'daemon off;'
autostart=true
autorestart=true
priority=10
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0

[program:php-fpm]
command=php-fpm -F
autostart=true
autorestart=true
priority=5
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0

[program:laravel-worker]
command=php artisan queue:work --sleep=3 --tries=3 --max-time=3600
directory=/var/www
autostart=true
autorestart=true
numprocs=2
stopwaitsecs=3600
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
```

**3.4 docker/entrypoint.sh:**
```bash
#!/bin/bash

echo "🚀 Iniciando despliegue de CPS Laravel..."

# Crear directorios necesarios
mkdir -p /var/www/storage/framework/{sessions,views,cache}
mkdir -p /var/www/storage/logs
mkdir -p /var/www/storage/app/{public,framework}
mkdir -p /var/www/bootstrap/cache

# Configurar permisos
chown -R www:www /var/www
chmod -R 775 /var/www/storage
chmod -R 775 /var/www/bootstrap/cache

echo "📦 Instalando dependencias..."
composer install --optimize-autoloader --no-dev --no-interaction

echo "🗄️ Ejecutando migraciones..."
php artisan migrate --force

echo "🔑 Generando clave de aplicación..."
php artisan key:generate --force

echo "📱 Optimizando aplicación..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "✅ Inicialización completada!"

# Iniciar supervisor
exec /usr/bin/supervisord -c /etc/supervisord.conf
```

### PASO 3: Subir Archivos a GitHub

**Opción A - Usando GitHub Web Interface:**
1. Ve a tu repositorio: https://github.com/qhosting/cps
2. Haz clic en "Add file" > "Create new file"
3. Nombre del archivo: `Dockerfile`
4. Copia el contenido del Dockerfile
5. Commit changes

**Opción B - Usando Git Command Line:**
```bash
git add Dockerfile docker-compose.yml
git add docker/php.ini docker/nginx.conf docker/supervisord.conf docker/entrypoint.sh
git commit -m "Add Docker configuration for CPS deployment"
git push origin main
```

### PASO 4: Reintentar Despliegue

Después de subir todos los archivos:
1. Regresa a tu panel de EasyPanel
2. Vuelve a intentar el despliegue
3. Ahora debería encontrar el Dockerfile sin problemas

## 🔍 VERIFICACIÓN RÁPIDA

Antes de subir, verifica que tienes:
- ✅ `Dockerfile` (en la raíz)
- ✅ `docker-compose.yml` (en la raíz)
- ✅ `docker/php.ini`
- ✅ `docker/nginx.conf`
- ✅ `docker/supervisord.conf`
- ✅ `docker/entrypoint.sh`

## 📞 SIGUIENTE PASO

Una vez que subas estos archivos, el error de "Dockerfile not found" desaparecerá y el despliegue debería continuar correctamente.