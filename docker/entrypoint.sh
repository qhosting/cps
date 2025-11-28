#!/bin/bash
set -e

# Script de inicialización para Sistema CPS
echo "🚀 Iniciando Sistema CPS en Docker..."

# Configurar usuario
if [ "$USER" != "www-data" ]; then
    exec su-exec www-data "$0" "$@"
fi

# Crear directorios necesarios
mkdir -p /var/www/html/storage/logs
mkdir -p /var/www/html/storage/framework/{cache,sessions,views}
mkdir -p /var/www/html/storage/app/public
mkdir -p /var/www/html/bootstrap/cache

# Configurar permisos
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/bootstrap/cache
chown -R www-data:www-data /var/www/html/storage
chown -R www-data:www-data /var/www/html/bootstrap/cache

# Verificar que el archivo .env existe
if [ ! -f "/var/www/html/.env" ]; then
    echo "⚠️  Archivo .env no encontrado, usando configuración por defecto..."
    if [ -f "/var/www/html/.env.easypanel" ]; then
        cp /var/www/html/.env.easypanel /var/www/html/.env
        echo "✅ Archivo .env copiado desde .env.easypanel"
    elif [ -f "/var/www/html/.env.example" ]; then
        cp /var/www/html/.env.example /var/www/html/.env
        echo "✅ Archivo .env copiado desde .env.example"
    else
        echo "❌ No se encontró archivo .env de configuración"
        exit 1
    fi
fi

# Generar APP_KEY si no está configurado
if grep -q "APP_KEY=base64:GENERAR_CLAVE_AQUI" /var/www/html/.env 2>/dev/null; then
    echo "🔑 Generando APP_KEY..."
    cd /var/www/html
    php artisan key:generate --force
    echo "✅ APP_KEY generado"
else
    echo "✅ APP_KEY ya configurado"
fi

# Optimizar para producción
echo "⚡ Optimizando para producción..."
cd /var/www/html
php artisan config:cache --force
php artisan route:cache --force
php artisan view:cache --force
php artisan optimize --force

# Verificar ionCube Loader
echo "🔒 Verificando ionCube Loader..."
if php -m | grep -q ioncube; then
    IONCUBE_VERSION=$(php -m | grep ioncube | head -n 1)
    echo "✅ ionCube Loader: $IONCUBE_VERSION"
else
    echo "❌ ionCube Loader no disponible"
fi

# Verificar conexión a base de datos (si las credenciales están configuradas)
if grep -q "DB_DATABASE=" /var/www/html/.env && grep -q "DB_USERNAME=" /var/www/html/.env && ! grep -q "DB_DATABASE=" /var/www/html/.env | grep -q "cps_db"; then
    echo "🗄️  Verificando conexión a base de datos..."
    if php artisan migrate:status > /dev/null 2>&1; then
        echo "✅ Conexión a base de datos exitosa"
    else
        echo "⚠️  No se pudo conectar a la base de datos (verificar credenciales en .env)"
    fi
fi

# Crear enlace simbólico para storage
echo "🔗 Creando enlace simbólico para storage..."
php artisan storage:link

# Verificar dependencias
echo "📦 Verificando dependencias..."
if [ -f "/var/www/html/vendor/autoload.php" ]; then
    echo "✅ Dependencias de Composer disponibles"
else
    echo "❌ Falta vendor/autoload.php, ejecutar: composer install"
fi

if [ -d "/var/www/html/node_modules" ] || [ -f "/var/www/html/public/build" ]; then
    echo "✅ Dependencias de Node.js disponibles"
else
    echo "⚠️  Dependencias de Node.js no encontradas, ejecutar: npm ci"
fi

# Limpiar logs antiguos
echo "🧹 Limpiando logs antiguos..."
find /var/www/html/storage/logs -name "*.log" -mtime +30 -delete 2>/dev/null || true

# Mostrar información del sistema
echo ""
echo "🎯 INFORMACIÓN DEL SISTEMA:"
echo "• Versión PHP: $(php -v | head -n 1)"
echo "• Versión Laravel: $(php artisan --version)"
echo "• Memoria límite: $(php -r 'echo ini_get("memory_limit");')"
echo "• Tiempo máximo ejecución: $(php -r 'echo ini_get("max_execution_time");')s"
echo "• Tamaño máximo archivo: $(php -r 'echo ini_get("upload_max_filesize");')"
echo "• ionCube: $(php -m | grep ioncube || echo 'No disponible')"
echo ""

# Mostrar URLs de acceso
echo "🌐 URLS DE ACCESO:"
if [ ! -z "$APP_URL" ]; then
    echo "• Sitio: $APP_URL"
    echo "• Panel Admin: $APP_URL/panel"
    echo "• API: $APP_URL/api/v1"
else
    echo "• Sitio: http://localhost"
    echo "• Panel Admin: http://localhost/panel"
    echo "• API: http://localhost/api/v1"
fi
echo ""

# Mostrar credenciales iniciales
echo "🔑 CREDENCIALES INICIALES:"
echo "• Email: admin@admin.com"
echo "• Contraseña: 123456"
echo "• ⚠️ CAMBIAR INMEDIATAMENTE después del primer login"
echo ""

# Configurar variables de entorno para la aplicación
if [ ! -z "$APP_ENV" ]; then
    sed -i "s/APP_ENV=production/APP_ENV=$APP_ENV/" /var/www/html/.env
fi

if [ ! -z "$APP_DEBUG" ]; then
    sed -i "s/APP_DEBUG=false/APP_DEBUG=$APP_DEBUG/" /var/www/html/.env
fi

echo "✅ Sistema CPS inicializado correctamente"
echo "🚀 Iniciando servicios..."

# Iniciar supervisord (que a su vez iniciará nginx y php-fpm)
exec "$@"