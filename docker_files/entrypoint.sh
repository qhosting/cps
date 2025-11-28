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