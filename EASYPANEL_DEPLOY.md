# 🚀 Guía de Despliegue CPS en EasyPanel (Todo en Uno)

Esta guía te permite desplegar el sistema CPS con **todos los servicios en un solo contenedor**:
- ✅ PHP 8.1 + FPM + ionCube Loader
- ✅ Nginx (servidor web)
- ✅ MariaDB (base de datos)
- ✅ Redis (caché y sesiones)
- ✅ Laravel Queue Worker
- ✅ Laravel Scheduler

---

## 📋 Requisitos Previos

- Acceso a EasyPanel
- El repositorio CPS subido a GitHub/GitLab (o usar imagen Docker)

---

## 🔧 Opción 1: Despliegue desde Repositorio Git

### Paso 1: Crear Nuevo Proyecto en EasyPanel

1. Accede a tu panel de EasyPanel
2. Click en **"Create Project"** o **"Nuevo Proyecto"**
3. Nombre del proyecto: `cps` (o el que prefieras)

### Paso 2: Crear Servicio de Aplicación

1. Dentro del proyecto, click en **"+ Service"** → **"App"**
2. Selecciona **"GitHub"** (o tu proveedor Git)
3. Conecta tu repositorio CPS
4. **IMPORTANTE**: En la configuración de Build:

```
Build Command: (dejar vacío, usa Dockerfile)
Dockerfile Path: Dockerfile.allinone
```

### Paso 3: Configurar Variables de Entorno

En la sección **"Environment Variables"**, añade:

```env
# === OBLIGATORIAS ===
APP_NAME=CPS
APP_ENV=production
APP_DEBUG=false

# === BASE DE DATOS (internos, puedes cambiar contraseñas) ===
DB_DATABASE=cps_database
DB_USERNAME=cps_user
DB_PASSWORD=TuPasswordSeguro123!
MYSQL_ROOT_PASSWORD=TuRootPasswordSeguro456!

# === LICENCIA CPS (si aplica) ===
APP_LICENSE=tu_licencia_aqui
API_TOKEN=tu_api_token_aqui

# === EMAIL (configurar según tu proveedor) ===
MAIL_HOST=smtp.tuproveedor.com
MAIL_PORT=587
MAIL_USERNAME=tu_email@dominio.com
MAIL_PASSWORD=tu_password_email
MAIL_FROM_ADDRESS=noreply@tudominio.com
MAIL_FROM_NAME=CPS System
```

### Paso 4: Configurar Dominio

1. En la sección **"Domains"**
2. Añade tu dominio: `cps.tudominio.com`
3. Habilita **HTTPS** (Let's Encrypt automático)

### Paso 5: Configurar Recursos

Recomendaciones mínimas para All-in-One:

| Recurso | Mínimo | Recomendado |
|---------|--------|-------------|
| CPU | 1 core | 2 cores |
| RAM | 1 GB | 2 GB |
| Disco | 5 GB | 10 GB |

### Paso 6: Configurar Volúmenes Persistentes

En la sección **"Mounts"** o **"Volumes"**, añade:

```
/var/lib/mysql → cps_mysql_data (para persistir base de datos)
/var/www/storage → cps_storage (para archivos subidos)
```

### Paso 7: Desplegar

1. Click en **"Deploy"** o **"Desplegar"**
2. Espera a que la imagen se construya (~5-10 minutos primera vez)
3. Verifica los logs para confirmar que todo inició correctamente

---

## 🔧 Opción 2: Despliegue con Docker Compose Local

Si prefieres construir la imagen localmente y subirla:

### Paso 1: Construir Imagen

```bash
cd /ruta/a/cps
docker build -f Dockerfile.allinone -t cps-allinone:latest .
```

### Paso 2: Etiquetar y Subir a Registry

```bash
# Para Docker Hub
docker tag cps-allinone:latest tuusuario/cps-allinone:latest
docker push tuusuario/cps-allinone:latest

# Para GitHub Container Registry
docker tag cps-allinone:latest ghcr.io/tuusuario/cps-allinone:latest
docker push ghcr.io/tuusuario/cps-allinone:latest
```

### Paso 3: En EasyPanel

1. Crear servicio tipo **"App"** → **"Docker Image"**
2. Imagen: `tuusuario/cps-allinone:latest`
3. Configurar variables de entorno (igual que Opción 1)
4. Desplegar

---

## 📊 Verificación Post-Despliegue

### 1. Verificar que los servicios están corriendo

Accede al contenedor vía SSH/Terminal de EasyPanel:

```bash
# Ver estado de todos los servicios
supervisorctl status

# Debería mostrar:
# mariadb                          RUNNING
# redis                            RUNNING
# nginx                            RUNNING
# php-fpm                          RUNNING
# laravel-queue                    RUNNING
# laravel-scheduler                RUNNING
```

### 2. Verificar la aplicación

- Accede a `https://tu-dominio.com`
- Deberías ver la página de login de CPS

### 3. Verificar logs

```bash
# Logs de Nginx
tail -f /var/log/nginx/cps-error.log

# Logs de Laravel
tail -f /var/www/storage/logs/laravel.log

# Logs de Supervisor
tail -f /var/log/supervisor/supervisord.log
```

---

## 🔐 Seguridad Post-Instalación

### 1. Cambiar contraseñas por defecto

Después del primer despliegue, cambia todas las contraseñas en las variables de entorno.

### 2. Configurar Backups

Programa backups regulares del volumen `/var/lib/mysql`:

```bash
# Ejemplo de backup manual
mysqldump -u root -p cps_database > backup_$(date +%Y%m%d).sql
```

### 3. Monitorear recursos

Vigila el uso de CPU y RAM. Si excede el 80% constantemente, considera aumentar recursos.

---

## 🛠️ Solución de Problemas

### Error: "ionCube Loader not found"

```bash
# Verificar ionCube
php -v | grep ionCube

# Debería mostrar algo como:
# with the ionCube PHP Loader v12.0.5
```

### Error: "Connection refused" a MySQL

```bash
# Verificar que MariaDB está corriendo
supervisorctl status mariadb

# Reiniciar si es necesario
supervisorctl restart mariadb
```

### Error: "Redis connection refused"

```bash
# Verificar Redis
redis-cli ping
# Debería responder: PONG

# Reiniciar si es necesario
supervisorctl restart redis
```

### Migraciones no se ejecutaron

```bash
# Ejecutar manualmente
cd /var/www
php artisan migrate --force
```

### Permisos incorrectos

```bash
chown -R app:app /var/www
chmod -R 775 /var/www/storage /var/www/bootstrap/cache
```

---

## 📁 Estructura de Archivos Creados

```
cps/
├── Dockerfile.allinone          # Dockerfile todo-en-uno
├── docker/
│   ├── supervisord-allinone.conf   # Configuración de Supervisor
│   ├── nginx-allinone.conf         # Configuración de Nginx
│   └── entrypoint-allinone.sh      # Script de inicialización
└── EASYPANEL_DEPLOY.md          # Esta guía
```

---

## 📞 Soporte

Si encuentras problemas durante el despliegue:

1. Revisa los logs de construcción en EasyPanel
2. Verifica las variables de entorno
3. Accede al contenedor y revisa `/var/log/supervisor/`

---

**Autor:** Matrix Agent  
**Versión:** 2.0.0-allinone  
**Última actualización:** Diciembre 2024
