# 🐳 Sistema CPS con Docker

Esta guía te permite desplegar el Sistema CPS (cPanel Seller) usando Docker y Docker Compose, incluyendo todos los servicios necesarios.

## 📋 Requisitos

- **Docker** 20.0+
- **Docker Compose** 2.0+
- **4GB RAM mínimo** (recomendado: 8GB)
- **10GB espacio libre** en disco

## 🚀 Despliegue Rápido

### 1️⃣ Clonar y Configurar

```bash
# Clonar repositorio
git clone https://github.com/qhosting/cps.git
cd cps

# Configurar variables de entorno
cp .env.docker .env
# Editar .env con tus configuraciones específicas
```

### 2️⃣ Desplegar

```bash
# Hacer ejecutable el script de despliegue
chmod +x deploy-docker.sh

# Ejecutar despliegue automático
./deploy-docker.sh
```

### 3️⃣ Acceder

- **Sitio Principal**: http://localhost
- **Panel Admin**: http://localhost/panel
- **phpMyAdmin**: http://localhost:8080
- **Redis Insight**: http://localhost:8001

## 🔧 Comandos Útiles

### Gestión de Servicios

```bash
# Ver estado de contenedores
docker compose ps

# Ver logs en tiempo real
docker compose logs -f web

# Acceder al shell del contenedor
docker compose exec web bash

# Reiniciar servicios
docker compose restart

# Parar servicios
docker compose down
```

### Base de Datos

```bash
# Acceder a MySQL desde host
mysql -h localhost -P 3306 -u cps_user -pcps_password

# Backup de base de datos
docker compose exec mysql mysqldump -u cps_user -pcps_password cps_db > backup.sql

# Restaurar base de datos
docker compose exec -i mysql mysql -u cps_user -pcps_password cps_db < backup.sql
```

### Cache y Optimización

```bash
# Limpiar cache de Laravel
docker compose exec web php artisan cache:clear
docker compose exec web php artisan config:clear
docker compose exec web php artisan view:clear

# Regenerar cache optimizado
docker compose exec web php artisan config:cache
docker compose exec web php artisan route:cache
docker compose exec web php artisan view:cache
```

## 📊 Servicios Incluidos

### 🐘 Aplicación Web (web)
- **PHP 8.1** con ionCube Loader
- **Nginx** como servidor web
- **Supervisord** para gestión de procesos
- **Optimizaciones Laravel** para producción

### 🗄️ Base de Datos (mysql)
- **MySQL 8.0** configurado para producción
- **Acceso desde phpMyAdmin** en puerto 8080
- **Persistencia de datos** en volumen Docker

### ⚡ Cache (redis)
- **Redis 7** para sesiones y caché
- **Redis Insight** para monitoreo en puerto 8001
- **Configuración con contraseña**

### 🔧 Herramientas de Desarrollo

#### phpMyAdmin (Puerto 8080)
- **Gestión visual** de base de datos MySQL
- **Acceso**: Servidor `mysql`, Usuario `root`, Contraseña `rootpassword`

#### Redis Insight (Puerto 8001)
- **Cliente Redis visual** para monitoreo
- **Gestión de sesiones y caché**

## 🔐 Configuración de Seguridad

### Variables de Entorno (.env)

```env
# Configuración segura para producción
APP_ENV=production
APP_DEBUG=false
SESSION_SECURE_COOKIE=true
SESSION_HTTP_ONLY=true

# CREDENCIALES IMPORTANTES (CAMBIAR)
DB_PASSWORD=cps_password
REDIS_PASSWORD=redis_password
MYSQL_ROOT_PASSWORD=rootpassword
```

### SSL/HTTPS

Para habilitar SSL, modifica `docker/nginx.conf`:

```nginx
server {
    listen 443 ssl http2;
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/private.key;
    # ... resto de configuración
}
```

## 🏗️ Arquitectura del Contenedor

```
┌─────────────────────────────────────────┐
│                Web Container             │
├─────────────────────────────────────────┤
│ ┌─────────────┐ ┌─────────────┐         │
│ │    Nginx    │ │  PHP-FPM    │         │
│ │     :80     │ │    :9000    │         │
│ └─────────────┘ └─────────────┘         │
│ ┌─────────────┐ ┌─────────────┐         │
│ │Supervisord  │ │   ionCube   │         │
│ │Manager      │ │   Loader    │         │
│ └─────────────┘ └─────────────┘         │
└─────────────────────────────────────────┘
         │                │
    ┌────▼────┐      ┌────▼────┐
    │  MySQL  │      │  Redis  │
    │ :3306   │      │ :6379   │
    └─────────┘      └─────────┘
```

## 🔧 Personalización

### Agregar Nuevos Servicios

Para agregar servicios adicionales, modifica `docker-compose.yml`:

```yaml
services:
  # Servicio existente
  web:
    # ... configuración

  # Nuevo servicio
  nuevo-servicio:
    image: imagen/nueva
    ports:
      - "puerto:80"
    networks:
      - cps-network
```

### Modificar Configuración PHP

Edita `docker/php.ini` para cambiar:
- Límites de memoria
- Timeouts
- Extensiones PHP
- Configuración OPcache

### Personalizar Nginx

Modifica `docker/nginx.conf` para:
- Headers de seguridad adicionales
- Configuración de gzip
- Rules de reescritura específicas

## 🐛 Troubleshooting

### Contenedor no inicia

```bash
# Ver logs detallados
docker compose logs web

# Verificar permisos
docker compose exec web ls -la /var/www/html

# Verificar variables de entorno
docker compose exec web cat /var/www/html/.env
```

### Error de conexión a base de datos

```bash
# Verificar que MySQL esté corriendo
docker compose ps mysql

# Verificar logs de MySQL
docker compose logs mysql

# Test de conectividad
docker compose exec web php artisan migrate:status
```

### Problemas de permisos

```bash
# Reparar permisos
docker compose exec web chown -R www-data:www-data /var/www/html/storage
docker compose exec web chmod -R 775 /var/www/html/storage
```

### ionCube Loader no funciona

```bash
# Verificar instalación
docker compose exec web php -m | grep ioncube

# Verificar versión PHP
docker compose exec web php -v
```

## 📈 Monitoreo y Logs

### Ubicación de Logs

```bash
# Logs de aplicación Laravel
docker compose exec web ls -la /var/www/html/storage/logs/

# Logs de Nginx
docker compose exec web tail -f /var/www/html/storage/logs/nginx_access.log

# Logs de PHP-FPM
docker compose exec web tail -f /var/www/html/storage/logs/php_fpm_supervisord.log
```

### Comandos de Monitoreo

```bash
# Uso de recursos
docker stats

# Espacio en disco
docker system df

# Limpiar recursos no utilizados
docker system prune -a
```

## 🔄 Actualizaciones

### Actualizar Código

```bash
# Actualizar desde Git
git pull origin main

# Reconstruir contenedor
docker compose up -d --build

# Ejecutar migraciones
docker compose exec web php artisan migrate
```

### Backup antes de Actualizar

```bash
# Backup de base de datos
docker compose exec mysql mysqldump -u root -prootpassword cps_db > backup_$(date +%Y%m%d).sql

# Backup de storage
tar -czf storage_backup_$(date +%Y%m%d).tar.gz storage/
```

## 💡 Tips de Producción

### Optimización

1. **Usar Redis para caché**
2. **Habilitar OPcache**
3. **Comprimir archivos estáticos**
4. **Configurar CDN para assets**

### Seguridad

1. **Cambiar todas las contraseñas por defecto**
2. **Configurar SSL/TLS**
3. **Usar variables de entorno seguras**
4. **Limitar acceso a puertos internos**

### Performance

1. **Monitorear uso de memoria**
2. **Optimizar consultas de base de datos**
3. **Configurar caché apropiado**
4. **Usar Redis para sesiones**

## 📞 Soporte

### Información del Sistema

```bash
# Información de Laravel
docker compose exec web php artisan --version

# Información de PHP
docker compose exec web php -v

# Información de ionCube
docker compose exec web php -m | grep ioncube
```

### Logs para Soporte

```bash
# Logs completos del sistema
docker compose logs > system_logs.txt

# Estado de contenedores
docker compose ps > containers_status.txt
```

---

**🎉 ¡Sistema CPS funcionando con Docker!**

Para soporte adicional, revisa la documentación completa en `DESPLIEGUE_EASYPANEL.md` o consulta los logs del sistema.

*Creado por MiniMax Agent - Sistema CPS Docker Deployment Guide v1.0*