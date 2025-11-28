# 🎯 Guía Completa de Despliegue del Sistema CPS en EasyPanel

## 📋 Resumen del Proyecto

**Sistema**: CPS (cPanel Seller) - Sistema de gestión de licencias cPanel
**Repositorio**: https://github.com/qhosting/cps
**Framework**: Laravel 9.x
**Protección**: ionCube Loader
**Estado**: ✅ Listo para despliegue en EasyPanel

---

## 🚀 Proceso de Despliegue Rápido

### 1️⃣ Pasos Iniciales

```bash
# 1. Accede a tu panel EasyPanel
# 2. Crear nuevo proyecto PHP
# 3. Conectar con GitHub
git clone https://github.com/qhosting/cps.git
cd cps
```

### 2️⃣ Instalación Automática

```bash
# Hacer ejecutable el script de instalación
chmod +x install-easypanel.sh

# Ejecutar instalación
./install-easypanel.sh
```

### 3️⃣ Verificación

```bash
# Verificar instalación
chmod +x verify-installation.sh
./verify-installation.sh
```

### 4️⃣ Configuración Final

```bash
# Configurar base de datos
php artisan migrate --force
php artisan db:seed --force

# Configurar cron jobs
* * * * * cd $(pwd) && php artisan schedule:run >> /dev/null 2>&1
```

---

## 📁 Archivos de Configuración Incluidos

### 📖 Documentación
- **`DESPLIEGUE_EASYPANEL.md`** - Guía completa paso a paso
- **`CONFIGURACION_EASYPANEL.md`** - Configuración avanzada del servidor

### ⚙️ Configuración
- **`.env.easypanel`** - Plantilla de configuración optimizada para EasyPanel
- **`.env.example`** - Configuración base del proyecto

### 🔧 Scripts Automáticos
- **`install-easypanel.sh`** - Instalación automática completa
- **`verify-installation.sh`** - Verificación post-instalación

---

## ⚡ Configuración Rápida del .env

```env
APP_NAME="Sistema CPS"
APP_ENV=production
APP_KEY=base64:GENERAR_CLAVE_AQUI
APP_DEBUG=false
APP_URL=https://tu-dominio.com

DB_DATABASE=cps_db
DB_USERNAME=tu_usuario
DB_PASSWORD=tu_password

CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
```

---

## 🌐 URLs de Acceso

- **Sitio Principal**: https://tu-dominio.com
- **Panel de Administración**: https://tu-dominio.com/panel
- **API REST**: https://tu-dominio.com/api/v1

### 🔑 Credenciales Iniciales
- **Email**: admin@admin.com
- **Contraseña**: 123456
- ⚠️ **Cambiar inmediatamente después del primer login**

---

## 🛠️ Requisitos del Servidor

### ✅ Extensiones PHP Requeridas
- ionCube Loader (CRÍTICO - Sistema protegido)
- MySQLi / PDO
- Redis
- cURL
- GD/Imagick
- OpenSSL
- Zip, XML, JSON
- Mbstring, Fileinfo

### ✅ Configuración del Sistema
- **PHP**: 8.0+ (Recomendado: 8.1+)
- **MySQL**: 5.7+ o 8.0+
- **Redis**: Para caché y sesiones
- **SSL**: Certificado SSL (Let's Encrypt recomendado)

---

## 📊 Características del Sistema

### 💳 Integraciones de Pago
- **Stripe** - Pagos con tarjeta
- **PayPal** - Pagos PayPal
- **SSLCommerz** - Pagos locales Bangladesh
- **UddoktaPay** - Pagos locales Bangladesh
- **Coinbase Commerce** - Criptomonedas

### 🎛️ Funcionalidades
- ✅ Gestión completa de licencias cPanel
- ✅ Panel de administración avanzado
- ✅ Sistema de tickets de soporte
- ✅ API REST completa
- ✅ Dashboard de métricas
- ✅ Sistema de notificaciones
- ✅ Gestión de usuarios y roles
- ✅ Reportes y estadísticas

### 🔒 Seguridad
- ✅ Archivos protegidos con ionCube
- ✅ Autenticación robusta
- ✅ Protección CSRF
- ✅ Validación de entrada
- ✅ Headers de seguridad
- ✅ HTTPS forzado

---

## 🚨 Troubleshooting Común

### ❌ Error 500 - Internal Server Error
**Solución**:
```bash
# Verificar permisos
chmod -R 775 storage/ bootstrap/cache/
chown -R www-data:www-data storage/ bootstrap/cache/

# Verificar logs
tail -f storage/logs/laravel.log
```

### ❌ Error ionCube Loader
**Solución**:
1. EasyPanel → PHP → Extensions
2. Habilitar "ionCube Loader"
3. Reiniciar servicio PHP

### ❌ Error de Base de Datos
**Solución**:
```bash
# Verificar conexión
php artisan migrate:status

# Regenerar cache
php artisan config:cache
php artisan migrate:fresh --seed
```

### ❌ Problemas de Permisos
**Solución**:
```bash
# Configurar permisos completos
chmod -R 755 .
chmod -R 775 storage/
chmod -R 775 bootstrap/cache/
chown -R www-data:www-data storage/ bootstrap/cache/
```

---

## 📈 Optimizaciones de Rendimiento

### 🚀 Aplicadas Automáticamente
- ✅ Autoloader optimizado
- ✅ Cache de configuración
- ✅ Cache de rutas
- ✅ Cache de vistas
- ✅ OPcache habilitado

### ⚡ Optimizaciones Adicionales
- Redis para sesiones y caché
- Compresión GZIP
- Headers de caché para archivos estáticos
- Minificación de assets

---

## 🔄 Proceso de Actualización

### 1. Actualizar Código
```bash
git pull origin main
composer install --optimize-autoloader --no-dev
```

### 2. Ejecutar Migraciones
```bash
php artisan migrate
php artisan config:cache
php artisan route:cache
```

### 3. Limpiar Cache
```bash
php artisan cache:clear
php artisan view:clear
php artisan config:clear
```

---

## 📞 Soporte y Mantenimiento

### 📋 Tareas de Mantenimiento Regular
- **Diario**: Verificar logs de error
- **Semanal**: Respaldar base de datos
- **Mensual**: Actualizar dependencias
- **Trimestral**: Revisar y renovar SSL

### 🛡️ Monitoreo Recomendado
- Configurar alertas por email
- Monitorear uso de recursos
- Verificar integraciones de pago
- Revisar logs de acceso

---

## ✨ ¡Despliegue Completado!

### 🎯 Próximos Pasos
1. ✅ Configurar dominio y SSL
2. ✅ Personalizar configuración de pagos
3. ✅ Configurar cron jobs
4. ✅ Probar todas las funcionalidades
5. ✅ Realizar primer respaldo
6. ✅ Configurar monitoreo

### 📚 Documentación Adicional
- **Laravel**: https://laravel.com/docs
- **EasyPanel**: https://www.easypanel.io/docs
- **ionCube**: https://ioncube.com

---

**🎉 ¡El Sistema CPS está listo para funcionar en EasyPanel!**

### 🔗 Enlaces Importantes
- **Repositorio**: https://github.com/qhosting/cps
- **Panel Admin**: https://tu-dominio.com/panel
- **Documentación**: `/workspace/DESPLIEGUE_EASYPANEL.md`
- **Configuración**: `/workspace/CONFIGURACION_EASYPANEL.md`

---

*Creado por MiniMax Agent - Sistema CPS Deployment Guide v1.0*