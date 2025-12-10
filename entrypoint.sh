#!/bin/bash
set -e

# Configurar puerto (default 3000, compatible con Easypanel)
export PORT=${PORT:-3000}

echo "=========================================="
echo "=== Iniciando aplicación Laravel CPS ==="
echo "=========================================="
echo "📡 Puerto configurado: $PORT"
echo "🔧 Configurando Nginx para puerto $PORT..."

# Crear configuración de nginx con el puerto correcto
envsubst '${PORT}' < /etc/nginx/nginx.conf > /tmp/nginx.conf.tmp
mv /tmp/nginx.conf.tmp /etc/nginx/nginx.conf

echo "✅ Nginx configurado correctamente"

# Verificar configuración de nginx
nginx -t

# Asegurar que los directorios tienen los permisos correctos
echo "🔐 Verificando permisos..."
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

echo "✅ Permisos configurados"
echo "=========================================="
echo "🚀 Iniciando servicios..."
echo "=========================================="

# Ejecutar comando pasado al contenedor
exec "$@"
