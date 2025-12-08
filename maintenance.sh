#!/bin/bash

# Comandos útiles para mantenimiento del Sistema CPS
# Ejecutar con: ./maintenance.sh [comando]

case "$1" in
    "status")
        echo "🔍 Verificando estado de los contenedores..."
        docker-compose ps
        echo ""
        echo "📊 Uso de recursos:"
        docker stats --no-stream
        ;;

    "logs")
        echo "📋 Últimos logs de la aplicación:"
        docker logs --tail=50 cps_app
        echo ""
        echo "📋 Últimos logs de MySQL:"
        docker logs --tail=50 cps_mysql
        ;;

    "backup")
        echo "💾 Creando backup de la base de datos..."
        BACKUP_DIR="./backups"
        mkdir -p $BACKUP_DIR
        BACKUP_FILE="$BACKUP_DIR/cps_backup_$(date +%Y%m%d_%H%M%S).sql"
        docker exec cps_mysql mysqldump -u cps_user -pcps_secure_password_2025 cps_system > $BACKUP_FILE
        echo "✅ Backup creado: $BACKUP_FILE"
        ;;

    "restore")
        if [ -z "$2" ]; then
            echo "❌ Uso: ./maintenance.sh restore <archivo_backup.sql>"
            exit 1
        fi
        echo "🔄 Restaurando desde backup: $2"
        docker exec -i cps_mysql mysql -u cps_user -pcps_secure_password_2025 cps_system < $2
        echo "✅ Restauración completada"
        ;;

    "clean")
        echo "🧹 Limpiando cache de Laravel..."
        docker exec cps_app php artisan cache:clear
        docker exec cps_app php artisan config:clear
        docker exec cps_app php artisan route:clear
        docker exec cps_app php artisan view:clear
        echo "✅ Cache limpiado"
        ;;

    "optimize")
        echo "⚡ Optimizando aplicación..."
        docker exec cps_app php artisan config:cache
        docker exec cps_app php artisan route:cache
        docker exec cps_app php artisan view:cache
        docker exec cps_app php artisan optimize
        echo "✅ Optimización completada"
        ;;

    "update")
        echo "🔄 Actualizando sistema..."
        docker-compose pull
        docker-compose build --no-cache
        docker-compose up -d
        echo "✅ Sistema actualizado"
        ;;

    "shell")
        echo "🐚 Accediendo al contenedor de la aplicación..."
        docker exec -it cps_app bash
        ;;

    "mysql")
        echo "🗄️ Accediendo a MySQL..."
        docker exec -it cps_mysql mysql -u cps_user -pcps_secure_password_2025 cps_system
        ;;

    "restart")
        echo "🔄 Reiniciando contenedores..."
        docker-compose restart
        echo "✅ Contenedores reiniciados"
        ;;

    "stop")
        echo "🛑 Deteniendo contenedores..."
        docker-compose down
        echo "✅ Contenedores detenidos"
        ;;

    "start")
        echo "▶️ Iniciando contenedores..."
        docker-compose up -d
        echo "✅ Contenedores iniciados"
        ;;

    "disk-usage")
        echo "💿 Uso de disco por contenedores:"
        docker system df
        echo ""
        echo "📁 Tamaño de volúmenes:"
        docker volume ls
        ;;

    "health")
        echo "🏥 Verificando salud del sistema..."
        
        # Verificar contenedores
        echo "📋 Estado de contenedores:"
        docker-compose ps
        
        echo ""
        echo "🌐 Verificando conectividad web..."
        if curl -f -s http://localhost > /dev/null; then
            echo "✅ Web: OK"
        else
            echo "❌ Web: ERROR"
        fi
        
        echo ""
        echo "🗄️ Verificando MySQL..."
        if docker exec cps_mysql mysqladmin ping -h localhost -u cps_user -pcps_secure_password_2025 --silent; then
            echo "✅ MySQL: OK"
        else
            echo "❌ MySQL: ERROR"
        fi
        
        echo ""
        echo "📊 Verificando Redis..."
        if docker exec cps_redis redis-cli ping > /dev/null 2>&1; then
            echo "✅ Redis: OK"
        else
            echo "❌ Redis: ERROR"
        fi
        ;;

    "migrate")
        echo "📊 Ejecutando migraciones..."
        docker exec cps_app php artisan migrate --force
        echo "✅ Migraciones ejecutadas"
        ;;

    "seed")
        echo "🌱 Ejecutando seeders..."
        docker exec cps_app php artisan db:seed --force
        echo "✅ Seeders ejecutados"
        ;;

    *)
        echo "🚀 Comandos de mantenimiento para Sistema CPS"
        echo ""
        echo "Uso: ./maintenance.sh [comando]"
        echo ""
        echo "Comandos disponibles:"
        echo "  status      - Ver estado de contenedores"
        echo "  logs        - Ver logs del sistema"
        echo "  backup      - Crear backup de BD"
        echo "  restore     - Restaurar desde backup"
        echo "  clean       - Limpiar cache"
        echo "  optimize    - Optimizar aplicación"
        echo "  update      - Actualizar sistema"
        echo "  shell       - Acceder al contenedor"
        echo "  mysql       - Acceder a MySQL"
        echo "  restart     - Reiniciar contenedores"
        echo "  stop        - Detener contenedores"
        echo "  start       - Iniciar contenedores"
        echo "  disk-usage  - Ver uso de disco"
        echo "  health      - Verificar salud del sistema"
        echo "  migrate     - Ejecutar migraciones"
        echo "  seed        - Ejecutar seeders"
        echo ""
        ;;
esac