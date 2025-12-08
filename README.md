# Sistema CPS - Despliegue Docker

Este proyecto contiene un sistema Laravel completo con PHP 8.3, ionCube 14 y MySQL, optimizado para Docker y compatible con Easypanel.

## 🚀 Características

- **PHP 8.3** con ionCube Loader 14 ✅ (Corregido)
- **Laravel 9** framework
- **MySQL 8.0** base de datos
- **Redis** para caché y sesiones  
- **Nginx** como servidor web separado
- **Docker Compose** para orquestación completa
- **Servicios independientes** para mejor escalabilidad

## 🔧 Estructura de Servicios

El docker-compose.yml incluye los siguientes servicios:

- **app**: Aplicación PHP-FPM con ionCube
- **web**: Servidor Nginx (separado)
- **mysql**: Base de datos MySQL 8.0
- **redis**: Sistema de caché Redis
- **phpmyadmin**: Panel de administración (puerto 8080)

## 📋 Requisitos

- Easypanel instalado y funcionando
- Docker y Docker Compose disponibles
- Al menos 2GB RAM disponible
- 10GB espacio en disco
- Puertos 80, 443, 8080 disponibles

## 🛠️ Instalación en Easypanel

### Paso 1: Preparar el servidor

1. **Accede a tu panel de Easypanel**
2. **Navega a la sección de Docker**
3. **Crea un nuevo proyecto o selecciona uno existente**

### Paso 2: Subir archivos

1. **Crea una carpeta en tu servidor:** `/var/www/cps-system/`
2. **Sube todos los archivos del proyecto:**
   - `Dockerfile`
   - `docker-compose.yml`
   - `nginx.conf`
   - `php.ini`
   - `.dockerignore`
   - `.env.example`
   - `init.sh`
   - Carpeta `system/` completa

### Paso 3: Configurar variables de entorno

1. **Copia `.env.example` a `.env`:**
   ```bash
   cp .env.example .env
   ```

2. **Edita el archivo `.env` y configura:**
   - `APP_URL`: Tu dominio
   - Credenciales de base de datos
   - API tokens
   - Configuración de Stripe/PayPal

### Paso 4: Configurar variables de entorno

1. **Copia el archivo de ejemplo:**
   ```bash
   cp .env.example .env
   ```

2. **Edita el archivo `.env` y configura:**
   - `APP_URL`: Tu dominio
   - `DB_PASSWORD`: Contraseña segura para MySQL
   - `DB_DATABASE`: Nombre de la base de datos
   - `DB_USERNAME`: Usuario de la base de datos
   - API tokens
   - Configuración de Stripe/PayPal

### Paso 5: Construir y ejecutar

1. **Construye y ejecuta todos los servicios:**
   ```bash
   docker-compose up -d --build
   ```

2. **Verifica que todos los servicios estén funcionando:**
   ```bash
   docker-compose ps
   ```

3. **Revisa los logs si hay problemas:**
   ```bash
   docker-compose logs app
   docker-compose logs web
   docker-compose logs mysql
   ```

3. **Ejecuta la inicialización:**
   ```bash
   docker-compose exec app bash init.sh
   ```

### Paso 6: Acceso a servicios

Una vez desplegado, puedes acceder a:

- **Aplicación principal**: http://tu-servidor (puerto 80)
- **PHPMyAdmin**: http://tu-servidor:8080 (para gestión de base de datos)
- **MySQL**: puerto 3306 (interno)
- **Redis**: puerto 6379 (interno)

### Paso 7: Configurar persistencia

Para hacer persistentes los datos después del despliegue inicial:

1. **Crear volúmenes persistentes en Easypanel:**
   ```bash
   docker volume create cps_mysql_data
   docker volume create cps_storage_data
   docker volume create cps_redis_data
   ```

2. **Modificar docker-compose.yml para usar volúmenes persistentes:**
   ```yaml
   volumes:
     mysql_data:
       external: true
       name: cps_mysql_data
     storage_data:
       external: true  
       name: cps_storage_data
   ```

3. **Reiniciar contenedores:**
   ```bash
   docker-compose down
   docker-compose up -d
   ```

## 🔧 Configuración

### Variables de entorno importantes

```env
# Aplicación
APP_URL=https://tu-dominio.com
APP_KEY=base64:tu-clave-generada

# Base de datos
DB_HOST=mysql
DB_DATABASE=cps_system
DB_USERNAME=cps_user
DB_PASSWORD=tu-password-seguro

# Cache y colas
CACHE_DRIVER=redis
QUEUE_CONNECTION=database
SESSION_DRIVER=file
```

### Configuración de ionCube

El sistema está preconfigurado con ionCube Loader. Los archivos PHP encriptados se descifrarán automáticamente.

## 📊 Estructura del proyecto

```
cps-system/
├── Dockerfile              # Imagen PHP 8.3 + ionCube
├── docker-compose.yml      # Stack completo (PHP + MySQL + Redis)
├── nginx.conf              # Configuración Nginx
├── php.ini                 # Configuración PHP
├── .dockerignore           # Archivos excluidos
├── .env.example            # Variables de entorno ejemplo
├── init.sh                 # Script de inicialización
└── system/                 # Código fuente Laravel
    ├── app/                # Aplicación Laravel
    ├── config/             # Configuraciones
    ├── database/           # Migraciones y seeders
    ├── public/             # Archivos públicos
    ├── routes/             # Rutas
    ├── storage/            # Archivos de almacenamiento
    └── vendor/             # Dependencias Composer
```

## 🔍 Monitoreo

### Ver logs

```bash
# Logs de la aplicación
docker logs cps_app

# Logs de MySQL
docker logs cps_mysql

# Logs de Redis
docker logs cps_redis
```

### Acceder a la base de datos

```bash
docker exec -it cps_mysql mysql -u cps_user -pcps_secure_password_2025 cps_system
```

### Acceder al contenedor PHP

```bash
docker exec -it cps_app bash
```

## 🔒 Seguridad

### Configuraciones implementadas

- ✅ ionCube para protección de código
- ✅ Variables de entorno seguras
- ✅ Headers de seguridad en Nginx
- ✅ Configuración PHP optimizada
- ✅ Cache y compresión habilitados

### Recomendaciones adicionales

1. **Cambia todas las contraseñas por defecto**
2. **Configura SSL/HTTPS**
3. **Actualiza las URLs del sistema de licenciamiento**
4. **Configura backups automáticos**

## 🚨 Solución de problemas

### Error: ionCube no funciona

```bash
# Verificar ionCube
docker exec -it cps_app php -v
```

### Error: Base de datos no conecta

```bash
# Verificar MySQL
docker exec -it cps_mysql mysql -u root -p
```

### Error: Permisos de archivos

```bash
# Reparar permisos
docker exec -it cps_app chown -R www-data:www-data /var/www/storage
docker exec -it cps_app chmod -R 775 /var/www/storage
```

## 📞 Soporte

Para soporte adicional:

1. Revisa los logs: `docker logs cps_app`
2. Verifica la configuración en `.env`
3. Asegúrate de que todos los servicios estén corriendo: `docker-compose ps`

## 🎯 Próximos pasos

1. **Configurar backups automáticos**
2. **Configurar SSL con Let's Encrypt**
3. **Monitoreo con herramientas como Grafana**
4. **Escalar horizontalmente si es necesario**

---

**¡El sistema está listo para producción!** 🎉