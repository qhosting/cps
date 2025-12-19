# 🚀 Guía de Despliegue CPS en EasyPanel - Puerto 3000

## 📋 Análisis del Sistema

**Sistema CPS** es una aplicación completa de gestión de licencias desarrollada en **Laravel** con las siguientes características:

- **Framework**: Laravel 9
- **PHP**: 8.3 con ionCube Loader 15.0.0
- **Base de datos**: MySQL 8.0
- **Cache**: Redis
- **Servidor web**: Nginx
- **Puerto configurado**: 3000 (optimizado para EasyPanel)

## 🎯 Archivos Creados para EasyPanel

He creado los siguientes archivos optimizados para el despliegue en EasyPanel:

### 1. `Dockerfile.easypanel`
Dockerfile optimizado que incluye:
- ✅ PHP 8.3 + ionCube Loader
- ✅ Nginx configurado para puerto 3000
- ✅ Supervisor para manejar servicios
- ✅ Health checks automáticos
- ✅ Configuración de seguridad

### 2. `docker-compose.easypanel.yml`
Compose simplificado para EasyPanel:
- ✅ Un solo contenedor con todo incluido
- ✅ Variables de entorno organizadas
- ✅ Recursos limitados apropiadamente
- ✅ Health checks configurados

### 3. `nginx.easypanel.conf`
Configuración Nginx optimizada:
- ✅ Puerto 3000
- ✅ Headers de seguridad
- ✅ Cache para archivos estáticos
- ✅ Endpoint de health check

### 4. `supervisord.conf`
Gestión de servicios:
- ✅ PHP-FPM
- ✅ Nginx
- ✅ Laravel Scheduler

### 5. `start.sh`
Script de inicio inteligente:
- ✅ Generación automática de APP_KEY
- ✅ Verificación de migraciones
- ✅ Configuración de permisos

## 🛠️ Instrucciones de Despliegue

### Paso 1: Preparar el Proyecto

1. **Accede a tu servidor EasyPanel**
2. **Navega a la sección Docker**
3. **Crea un nuevo proyecto o selecciona uno existente**

### Paso 2: Subir Archivos

Sube los siguientes archivos a tu directorio del proyecto:

```
cps/
├── Dockerfile.easypanel          # ← Usar este Dockerfile
├── docker-compose.easypanel.yml  # ← Usar este compose
├── nginx.easypanel.conf
├── supervisord.conf
├── start.sh
└── system/                       # ← Código fuente Laravel
```

### Paso 3: Configurar Variables de Entorno

En EasyPanel, configura estas variables de entorno:

#### Variables Obligatorias:
```bash
# Aplicación
APP_ENV=production
APP_DEBUG=false
APP_URL=https://tu-dominio.com
PORT=3000

# Base de datos (MySQL externa o en EasyPanel)
DB_HOST=mysql
DB_DATABASE=cps_database
DB_USERNAME=cps_user
DB_PASSWORD=tu_password_seguro

# Redis (externo o en EasyPanel)
REDIS_HOST=redis
REDIS_PORT=6379

# Correo
MAIL_MAILER=smtp
MAIL_HOST=smtp.tu-proveedor.com
MAIL_PORT=587
MAIL_USERNAME=noreply@tu-dominio.com
MAIL_PASSWORD=tu_password_mail
```

#### Variables Opcionales (Pagos):
```bash
STRIPE_KEY=pk_test_tu_clave_publica
STRIPE_SECRET=sk_test_tu_clave_secreta
```

### Paso 4: Configurar Base de Datos

#### Opción A: MySQL en EasyPanel
1. **Crea una base de datos MySQL** en EasyPanel
2. **Anota las credenciales** (host, puerto, usuario, password)
3. **Actualiza las variables de entorno** con esos valores

#### Opción B: MySQL Externo
Si usas MySQL externo, asegúrate de que sea accesible desde el contenedor.

### Paso 5: Configurar Redis

#### Opción A: Redis en EasyPanel
1. **Crea una instancia Redis** en EasyPanel
2. **Actualiza las variables** con los datos de conexión

#### Opción B: Redis Externo
Si usas Redis externo, verifica la conectividad.

### Paso 6: Desplegar

1. **Construye la imagen**:
   ```bash
   docker-compose -f docker-compose.easypanel.yml build
   ```

2. **Inicia el contenedor**:
   ```bash
   docker-compose -f docker-compose.easypanel.yml up -d
   ```

3. **Verifica el estado**:
   ```bash
   docker-compose -f docker-compose.easypanel.yml ps
   ```

### Paso 7: Verificar Despliegue

1. **Accede a la aplicación**: `http://tu-servidor:3000`
2. **Verifica el health check**: `http://tu-servidor:3000/health`
3. **Revisa los logs**:
   ```bash
   docker logs cps-system
   ```

## 🔧 Comandos Útiles

### Ver logs en tiempo real:
```bash
docker logs -f cps-system
```

### Acceder al contenedor:
```bash
docker exec -it cps-system bash
```

### Ejecutar comandos Artisan:
```bash
docker exec -it cps-system php artisan migrate
docker exec -it cps-system php artisan config:cache
docker exec -it cps-system php artisan route:cache
```

### Reiniciar servicios:
```bash
docker-compose -f docker-compose.easypanel.yml restart
```

### Parar el servicio:
```bash
docker-compose -f docker-compose.easypanel.yml down
```

## 📊 Monitoreo

### Health Check
La aplicación incluye un endpoint de health check en `/health` que devuelve:
- Estado de la aplicación
- Conectividad a la base de datos
- Estado de Redis

### Logs
Los logs se almacenan en:
- **Aplicación**: `/var/log/supervisor/`
- **Nginx**: `/var/log/nginx/`
- **PHP**: `/var/log/php/`

### Métricas
EasyPanel mostrará automáticamente:
- Uso de CPU y memoria
- Estado del contenedor
- Logs de la aplicación

## 🚨 Solución de Problemas

### Error: Puerto 3000 en uso
```bash
# Verificar qué proceso usa el puerto
netstat -tlnp | grep :3000

# Cambiar puerto en variables de entorno
PORT=3001
```

### Error: No se conecta a MySQL
```bash
# Verificar conectividad
docker exec -it cps-system nc -zv mysql 3306

# Verificar credenciales en .env
docker exec -it cps-system cat /var/www/.env | grep DB_
```

### Error: Permisos de archivos
```bash
# Reparar permisos
docker exec -it cps-system chown -R www-data:www-data /var/www/storage
docker exec -it cps-system chmod -R 775 /var/www/storage
```

### Error: ionCube no funciona
```bash
# Verificar ionCube
docker exec -it cps-system php -v
```

## 🔒 Configuración de Seguridad

### SSL/HTTPS
Para configurar SSL en EasyPanel:
1. **Activa SSL** en la configuración del proyecto
2. **Actualiza APP_URL** a `https://tu-dominio.com`
3. **Reinicia el contenedor**

### Firewall
Asegúrate de que el puerto 3000 esté abierto:
```bash
ufw allow 3000
```

### Variables Sensibles
Nunca expongas en repositorios públicos:
- `DB_PASSWORD`
- `STRIPE_SECRET`
- `MAIL_PASSWORD`
- `APP_KEY`

## 📈 Optimización para Producción

### Cache
```bash
# Limpiar cache
docker exec -it cps-system php artisan cache:clear
docker exec -it cps-system php artisan config:cache
docker exec -it cps-system php artisan route:cache
docker exec -it cps-system php artisan view:cache
```

### Optimización de Base de Datos
```bash
# Optimizar tablas
docker exec -it cps-system php artisan db:optimize
```

### Logs
```bash
# Limpiar logs antiguos
docker exec -it cps-system php artisan log:clear
```

## 🎯 Próximos Pasos

1. **✅ Configurar backups automáticos** en EasyPanel
2. **✅ Configurar monitoreo** con alertas
3. **✅ Configurar SSL** con Let's Encrypt
4. **✅ Configurar CDN** para archivos estáticos
5. **✅ Configurar workers** para colas de trabajo

---

## 📞 Soporte

Si tienes problemas durante el despliegue:

1. **Revisa los logs**: `docker logs cps-system`
2. **Verifica las variables de entorno** en EasyPanel
3. **Comprueba la conectividad** a MySQL y Redis
4. **Verifica los permisos** de archivos y directorios

**¡El sistema está optimizado y listo para producción!** 🎉

---

**Autor**: MiniMax Agent  
**Fecha**: 2025-12-19  
**Versión**: 1.0  
**Puerto**: 3000 (optimizado para EasyPanel)