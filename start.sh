#!/bin/bash
set -e

# Script de inicio para EasyPanel - Puerto 3000
echo "=========================================="
echo "=== Sistema CPS - EasyPanel Startup ==="
echo "=========================================="

# Configurar variables de entorno
export PORT=${PORT:-3000}
export DB_HOST=${DB_HOST:-localhost}
export DB_DATABASE=${DB_DATABASE:-cps_system}
export DB_USERNAME=${DB_USERNAME:-cps_user}
export DB_PASSWORD=${DB_PASSWORD:-cps_secure_password_2025}

echo "📡 Puerto configurado: $PORT"
echo "🗄️ Base de datos: $DB_DATABASE"
echo "🔧 Configurando aplicación..."

# Generar APP_KEY si no existe
if [ ! -f "/var/www/.env" ] || ! grep -q "APP_KEY=" /var/www/.env || grep -q "APP_KEY=$" /var/www/.env; then
    echo "🔑 Generando APP_KEY..."
    cd /var/www
    php artisan key:generate --force
    echo "✅ APP_KEY generado"
fi

# Ejecutar migraciones si es necesario
if [ "$APP_ENV" = "production" ]; then
    echo "🔄 Verificando migraciones..."
    cd /var/www
    php artisan migrate:status
    echo "✅ Migraciones verificadas"
fi

# Configurar permisos
echo "🔐 Configurando permisos..."
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache
echo "✅ Permisos configurados"

# Verificar configuración de nginx
echo "🌐 Verificando configuración Nginx..."
nginx -t
echo "✅ Nginx configurado correctamente"

# Crear directorio para logs de supervisor
mkdir -p /var/log/supervisor
chown www-data:www-data /var/log/supervisor

echo "=========================================="
echo "🚀 Iniciando servicios con Supervisor..."
echo "=========================================="

# Iniciar supervisor (que maneará PHP-FPM y Nginx)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf