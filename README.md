# Sistema CPS - Despliegue en Easypanel

Este proyecto contiene un sistema Laravel completo con PHP 8.3, ionCube 14 y MySQL, listo para desplegar en Easypanel.

## 🚀 Características

- **PHP 8.3** con ionCube Loader
- **Laravel 9.0** framework
- **MySQL** base de datos
- **Nginx** servidor web
- **Redis** cache y colas
- **Configuración todo-en-uno** en Docker

## 📋 Requisitos

- Easypanel instalado y funcionando
- Docker y Docker Compose disponibles
- Al menos 2GB RAM disponible
- 10GB espacio en disco

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

### Paso 4: Construir y ejecutar

1. **Construye la imagen Docker:**
   ```bash
   cd /var/www/cps-system/
   docker-compose build
   ```

2. **Ejecuta los contenedores:**
   ```bash
   docker-compose up -d
   ```

3. **Ejecuta la inicialización:**
   ```bash
   chmod +x init.sh
   ./init.sh
   ```

### Paso 5: Configurar persistencia

Para hacer persistentes los datos después del despliegue inicial:

1. **Crear volúmenes persistentes en Easypanel:**
   ```bash
   docker volume create cps_mysql_data
   docker volume create cps_storage_data
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