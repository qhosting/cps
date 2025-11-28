# Guía de Despliegue en EasyPanel - Sistema CPS

Esta guía te ayudará a desplegar el sistema CPS (cPanel Seller) en EasyPanel de manera rápida y eficiente.

## 🚀 Pasos de Despliegue

### 1. Configurar el Proyecto en EasyPanel

1. **Accede a tu panel de EasyPanel**:
   - Ve a tu dominio EasyPanel (ej: `https://tu-dominio.com:3000`)
   - Inicia sesión con tus credenciales

2. **Crear Nuevo Proyecto Web**:
   - Haz clic en "Websites" → "Add Website"
   - Selecciona tu dominio o subdominio
   - Tipo de proyecto: **PHP Application**
   - Versión PHP: **PHP 8.0+** (recomendado: PHP 8.1)

### 2. Configuración de Variables de Entorno

1. **Archivo `.env`**:
   Crea el archivo `.env` en la raíz del proyecto con estas variables esenciales:

   ```env
   # Configuración de la Aplicación
   APP_NAME="Sistema CPS"
   APP_ENV=production
   APP_KEY=base64:GENERAR_CLAVE_AQUI
   APP_DEBUG=false
   APP_URL=https://tu-dominio.com

   # Configuración de Base de Datos
   DB_CONNECTION=mysql
   DB_HOST=localhost
   DB_PORT=3306
   DB_DATABASE=cps_db
   DB_USERNAME=tu_usuario_db
   DB_PASSWORD=tu_password_db

   # Configuración de Caché
   CACHE_DRIVER=redis
   REDIS_HOST=localhost
   REDIS_PORT=6379

   # Configuración de Cola
   QUEUE_CONNECTION=redis

   # Configuración de Cache de Sesiones
   SESSION_DRIVER=redis
   SESSION_LIFETIME=120

   # Configuración de Email
   MAIL_MAILER=smtp
   MAIL_HOST=tu-smtp-host
   MAIL_PORT=587
   MAIL_USERNAME=tu-email@dominio.com
   MAIL_PASSWORD=tu-password
   MAIL_ENCRYPTION=tls
   MAIL_FROM_ADDRESS=noreply@tu-dominio.com
   MAIL_FROM_NAME="Sistema CPS"

   # Configuración de Pagos
   STRIPE_KEY=pk_live_tu_clave_publica
   STRIPE_SECRET=sk_live_tu_clave_secreta

   # Configuración de PayPal
   PAYPAL_CLIENT_ID=tu_paypal_client_id
   PAYPAL_CLIENT_SECRET=tu_paypal_client_secret
   PAYPAL_MODE=live

   # Configuración de ionCube (si está disponible)
   ionCube=enabled
   ```

2. **Generar APP_KEY**:
   Para generar una nueva APP_KEY, ejecuta este comando en la terminal del servidor:
   ```bash
   php artisan key:generate --force
   ```

### 3. Instalación de Dependencias

1. **Composer**:
   En la terminal de EasyPanel, ejecuta:
   ```bash
   cd /path/to/your/website
   composer install --optimize-autoloader --no-dev
   ```

2. **NPM (si es necesario)**:
   ```bash
   npm install --production
   npm run build
   ```

### 4. Configuración de Base de Datos

1. **Crear Base de Datos**:
   - Ve a "Databases" en EasyPanel
   - Crea una nueva base de datos MySQL
   - Anota el nombre, usuario y contraseña

2. **Migrar la Base de Datos**:
   ```bash
   php artisan migrate --force
   ```

3. **Cargar Datos Iniciales**:
   ```bash
   php artisan db:seed --force
   ```

### 5. Configuración de Permisos

1. **Permisos de Directorios**:
   ```bash
   chmod -R 755 /path/to/your/website
   chmod -R 775 /path/to/your/website/storage
   chmod -R 775 /path/to/your/website/bootstrap/cache
   ```

2. **Propietario de Archivos**:
   ```bash
   chown -R www-data:www-data /path/to/your/website
   ```

### 6. Configuración de ionCube Loader

1. **Verificar ionCube**:
   - Accede a tu panel de EasyPanel
   - Ve a "PHP" → "Extensions"
   - Busca y habilita "ionCube Loader"

2. **Verificar Instalación**:
   Crea un archivo `phpinfo.php` para verificar:
   ```php
   <?php phpinfo(); ?>
   ```

### 7. Optimizaciones para Producción

1. **Optimizar Autoloader**:
   ```bash
   composer dump-autoload --optimize --classmap-authoritative
   ```

2. **Cache de Configuración**:
   ```bash
   php artisan config:cache
   ```

3. **Cache de Rutas**:
   ```bash
   php artisan route:cache
   ```

4. **Cache de Vistas**:
   ```bash
   php artisan view:cache
   ```

### 8. Configuración de SSL (Recomendado)

1. **SSL en EasyPanel**:
   - Ve a "SSL" en el panel
   - Habilita SSL para tu dominio
   - Usa Let's Encrypt (gratuito) o tu certificado SSL

### 9. Configuración de Cron Jobs

Agrega estos jobs a la crontab del servidor:

```bash
# Editar crontab
crontab -e

# Agregar estas líneas
* * * * * cd /path/to/your/website && php artisan schedule:run >> /dev/null 2>&1
* * * * * cd /path/to/your/website && php artisan queue:work --stop-when-empty >> /dev/null 2>&1
```

## 🔧 Configuraciones Específicas del Sistema CPS

### Panel de Administración
- URL: `https://tu-dominio.com/panel`
- Usuario por defecto: admin@admin.com
- Contraseña por defecto: 123456 (cambiar inmediatamente)

### Características del Sistema
- ✅ Gestión de licencias cPanel
- ✅ Integración de pagos (Stripe, PayPal, SSLCommerz, UddoktaPay, Coinbase)
- ✅ Sistema de tickets
- ✅ Panel de clientes
- ✅ API REST
- ✅ Dashboard administrativo

## 🚨 Troubleshooting Común

### Error 500 - Internal Server Error
1. Verificar logs de error en EasyPanel
2. Comprobar permisos de archivos
3. Verificar configuración .env

### Error de ionCube
1. Verificar que ionCube Loader esté habilitado
2. Comprobar compatibilidad de versión PHP

### Error de Base de Datos
1. Verificar credenciales de BD
2. Comprobar conexión MySQL
3. Ejecutar migraciones nuevamente

### Error de Permisos
```bash
chmod -R 775 storage/
chmod -R 775 bootstrap/cache/
chown -R www-data:www-data storage/
chown -R www-data:www-data bootstrap/cache/
```

## 📋 Checklist Final

- [ ] Proyecto creado en EasyPanel
- [ ] PHP 8.0+ configurado
- [ ] ionCube Loader habilitado
- [ ] Archivo .env configurado
- [ ] Dependencias instaladas (composer)
- [ ] Base de datos creada y migrada
- [ ] Permisos configurados
- [ ] SSL configurado (recomendado)
- [ ] Cron jobs configurados
- [ ] Sistema accesible vía web
- [ ] Panel de administración funcional

## 📞 Soporte

Si encuentras problemas durante el despliegue:

1. **Revisa los logs** en EasyPanel → Logs
2. **Verifica la configuración** del .env
3. **Comprueba los permisos** de archivos y directorios
4. **Asegúrate de que ionCube esté habilitado**

## 🎯 URLs de Acceso

- **Sitio Principal**: https://tu-dominio.com
- **Panel de Administración**: https://tu-dominio.com/panel
- **API**: https://tu-dominio.com/api/v1

---

**¡Sistema CPS desplegado y listo para usar!** 🎉