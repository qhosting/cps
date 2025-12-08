#!/bin/bash

# Script de inicialización para el sistema CPS
echo "🚀 Inicializando sistema CPS..."

# Esperar a que MySQL esté listo
echo "⏳ Esperando a que MySQL esté disponible..."
until mysqladmin ping -h mysql -u cps_user -pcps_secure_password_2025 --silent; do
    echo "Esperando MySQL..."
    sleep 2
done

echo "✅ MySQL está disponible"

# Copiar archivo .env si no existe
if [ ! -f /var/www/.env ]; then
    echo "📄 Copiando archivo .env.example a .env"
    cp /var/www/.env.example /var/www/.env
fi

# Generar APP_KEY si no existe
if ! grep -q "APP_KEY=base64:" /var/www/.env; then
    echo "🔑 Generando APP_KEY..."
    docker exec -it cps_app php artisan key:generate --force
fi

# Ejecutar migraciones
echo "📊 Ejecutando migraciones de base de datos..."
docker exec -it cps_app php artisan migrate --force

# Ejecutar seeders (opcional)
echo "🌱 Ejecutando seeders..."
docker exec -it cps_app php artisan db:seed --force

# Limpiar cache
echo "🧹 Limpiando cache..."
docker exec -it cps_app php artisan config:cache
docker exec -it cps_app php artisan route:cache
docker exec -it cps_app php artisan view:cache

# Establecer permisos correctos
echo "🔐 Estableciendo permisos..."
docker exec -it cps_app chown -R www-data:www-data /var/www/storage
docker exec -it cps_app chmod -R 775 /var/www/storage

echo "✅ Inicialización completada"
echo "🌐 El sistema está disponible en: http://localhost"
echo "🔧 Para ver logs: docker logs cps_app"