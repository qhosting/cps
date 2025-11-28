# Configuración Paso a Paso: Variables de Entorno en EasyPanel

## 🚀 Acceso a la Configuración del Proyecto

### Paso 1: Navegar al Proyecto
1. **Accede a EasyPanel**: Abre tu navegador y ve a tu panel EasyPanel
2. **Seleccionar Proyecto**: En la lista de proyectos, busca y haz clic en **"cps_qhosting"**
3. **Acceder a Configuración**: Una vez dentro del proyecto, busca el botón **"Configuración"** o **"Settings"** (generalmente en la parte superior del proyecto)

### Paso 2: Localizar Variables de Entorno
En la página de configuración del proyecto, busca una sección llamada:
- **"Variables de Entorno"** 
- **"Environment Variables"**
- **"Configuración de Variables"**
- **".env Configuration"**

## 📋 Configuración de Variables Manuales

### Variables Esenciales para tu Sistema CPS

Copia y pega exactamente estas variables en tu panel de EasyPanel:

#### Configuración Básica de la Aplicación
```
APP_NAME = CPS
APP_ENV = production
APP_DEBUG = false
APP_VERSION = 120.55.1
```

#### Configuración de Licencia (CRÍTICO)
```
APP_LICENSE = license_tu_clave_de_licencia_aqui
API_TOKEN = tu_token_api_aqui
```

#### URLs de Licenciamiento (Opcional pero Recomendado)
```
SYS_LIC_SERVER_MODULE = https://tu-servidor.com/syslicensing.zip
SYS_LIC_ADDON_MODULE = https://tu-servidor.com/licensing.zip
SYS_LIC_API_URL = https://tu-servidor.com/
```

#### Configuración de Stripe (Si usas pagos por Stripe)
```
STRIPE_KEY = pk_live_tu_clave_publica_stripe
STRIPE_SECRET = sk_live_tu_clave_secreta_stripe
STRIPE_WEBHOOK_SECRET = whsec_tu_webhook_secret
```

#### Configuración de Email (OBLIGATORIO)
```
MAIL_HOST = smtp.tu-proveedor-email.com
MAIL_PORT = 587
MAIL_USERNAME = tu-email@dominio.com
MAIL_PASSWORD = tu_password_email
MAIL_ENCRYPTION = tls
MAIL_FROM_ADDRESS = noreply@tu-dominio.com
MAIL_FROM_NAME = CPS System
```

## 🔧 Variables que EasyPanel Configura Automáticamente

EasyPanel establecerá automáticamente estas variables (NO las configures manualmente):

### Variables del Sistema
- `EASYPANEL = true`
- `EASYPANEL_PROJECT = cps_qhosting`
- `EASYPANEL_DOMAIN = tu-dominio.com`
- `HOST = 0.0.0.0`
- `PORT = 80`

### Variables de Base de Datos
- `DB_HOST = mysql`
- `DB_PORT = 3306`
- `DB_DATABASE = cps_database`
- `DB_USERNAME = cps_user`
- `DB_PASSWORD = cps_password_123`

### Variables de Redis
- `REDIS_HOST = redis`
- `REDIS_PORT = 6379`
- `REDIS_PASSWORD = null`

## ⚙️ Proceso de Configuración Detallado

### Método 1: Configuración Manual (Recomendado para Principiantes)

1. **Acceder a Variables**:
   ```
   Proyecto → Configuración → Variables de Entorno → Agregar Variable
   ```

2. **Agregar cada variable individualmente**:
   - **Nombre**: `APP_NAME`
   - **Valor**: `CPS`
   - Hacer clic en **"Agregar"** o **"Save"**

3. **Repetir para todas las variables** listadas arriba

### Método 2: Configuración en Lote (Para usuarios avanzados)

Algunos paneles de EasyPanel permiten cargar variables en formato JSON:

```json
{
  "APP_NAME": "CPS",
  "APP_ENV": "production", 
  "APP_DEBUG": "false",
  "APP_LICENSE": "license_tu_clave_de_licencia_aqui",
  "API_TOKEN": "tu_token_api_aqui",
  "MAIL_HOST": "smtp.tu-proveedor-email.com",
  "MAIL_USERNAME": "tu-email@dominio.com",
  "MAIL_PASSWORD": "tu_password_email"
}
```

## 🔍 Verificación de la Configuración

### Paso 1: Verificar que las Variables están Aplicadas
1. Ve a la sección de **"Logs"** o **"Logs del Proyecto"**
2. Busca entradas como:
   ```
   [INFO] EasyPanel Host: server.easypanel.io
   [INFO] Project: cps_qhosting
   [INFO] APP_URL: https://tu-dominio.com/
   ```

### Paso 2: Crear Script de Verificación
En tu contenedor, ejecuta este comando para verificar las variables:

```bash
# Acceder al contenedor
docker exec -it cps_app /bin/bash

# Verificar variables críticas
php -r "
\$vars = ['APP_NAME', 'APP_ENV', 'APP_KEY', 'DB_HOST', 'REDIS_HOST'];
foreach (\$vars as \$var) {
    \$value = getenv(\$var) ?: 'NO DEFINIDA';
    echo \"\$var: \$value\" . PHP_EOL;
}
"
```

### Paso 3: Verificar Conectividad
Ejecuta este script para verificar la conectividad:

```bash
# Verificar MySQL
mysql -h$DB_HOST -P$DB_PORT -u$DB_USERNAME -p$DB_PASSWORD -e "SELECT 1;"

# Verificar Redis
redis-cli -h$REDIS_HOST -p$REDIS_PORT ping
```

## 🚨 Errores Comunes y Soluciones

### Error 1: Variables no se cargan
**Síntomas**: La aplicación muestra errores sobre variables faltantes

**Solución**:
1. Verificar que todas las variables están guardadas en EasyPanel
2. Reiniciar el contenedor desde EasyPanel
3. Verificar logs para errores específicos

### Error 2: Error de conexión a base de datos
**Síntomas**: `SQLSTATE[HY000] [2002] Connection refused`

**Solución**:
1. Verificar que `DB_HOST=mysql` está configurado
2. Verificar que el contenedor MySQL esté corriendo
3. Verificar credenciales de base de datos

### Error 3: ionCube no funciona
**Síntomas**: Errores de PHP sobre archivos encriptados

**Solución**:
1. Verificar que la extensión está instalada
2. Verificar que la licencia de ionCube es válida
3. Revisar logs de PHP

### Error 4: Redis no conecta
**Síntomas**: Errores de sesión o caché

**Solución**:
1. Verificar que `REDIS_HOST=redis` está configurado
2. Verificar que el contenedor Redis esté corriendo
3. Probar conectividad con `redis-cli`

## 🔄 Actualización y Re-despliegue

### Cuando cambies Variables de Entorno:

1. **Guardar cambios en EasyPanel**
2. **Re-iniciar el contenedor**: Busca el botón "Restart" o "Re-iniciar"
3. **Verificar logs** para confirmar que las nuevas variables están cargadas
4. **Probar la aplicación** en tu navegador

### Script de Re-despliegue Automático:

```bash
#!/bin/bash
echo "Reiniciando contenedor con nuevas variables..."
docker-compose restart

echo "Esperando a que los servicios estén listos..."
sleep 10

echo "Verificando estado de los contenedores..."
docker-compose ps

echo "Verificando logs recientes..."
docker-compose logs --tail=20

echo "✅ Re-despliegue completado"
```

## 📊 Monitoreo de Variables en Producción

### Dashboard de Monitoreo

Crea un archivo `monitor.php` para monitorear el estado:

```php
<?php
// monitor.php - Colocar en public/

header('Content-Type: application/json');

$status = [
    'timestamp' => date('Y-m-d H:i:s'),
    'environment' => getenv('APP_ENV'),
    'easypanel' => getenv('EASYPANEL'),
    'database' => false,
    'redis' => false,
    'cache' => false
];

// Verificar base de datos
try {
    $pdo = new PDO(
        "mysql:host=" . getenv('DB_HOST') . ";dbname=" . getenv('DB_DATABASE'),
        getenv('DB_USERNAME'),
        getenv('DB_PASSWORD')
    );
    $status['database'] = true;
} catch (Exception $e) {
    $status['database_error'] = $e->getMessage();
}

// Verificar Redis
try {
    $redis = new Redis();
    $redis->connect(getenv('REDIS_HOST'), getenv('REDIS_PORT'));
    $redis->ping();
    $status['redis'] = true;
} catch (Exception $e) {
    $status['redis_error'] = $e->getMessage();
}

// Verificar caché
try {
    $status['cache'] = app('cache')->store()->getStore() ? true : false;
} catch (Exception $e) {
    $status['cache_error'] = $e->getMessage();
}

echo json_encode($status, JSON_PRETTY_PRINT);
?>
```

### Acceso al Monitoreo:
- URL: `https://tu-dominio.com/monitor.php`
- Solo disponible para administradores
- Usar para verificar el estado de la aplicación

## 🎯 Checklist Final

Antes de considerar la configuración completa, verifica:

- [ ] ✅ Todas las variables manuales están configuradas en EasyPanel
- [ ] ✅ ionCube Loader está funcionando
- [ ] ✅ Base de datos MySQL responde correctamente
- [ ] ✅ Redis está conectado y funcionando
- [ ] ✅ Email está configurado y probado
- [ ] ✅ Variables automáticas de EasyPanel están disponibles
- [ ] ✅ Aplicación carga sin errores en el navegador
- [ ] ✅ Logs no muestran errores críticos
- [ ] ✅ SSL/HTTPS está funcionando (si está habilitado)

## 📞 Soporte y Debugging

### Información para Soporte
Si necesitas ayuda, proporciona:

1. **Screenshot de la configuración de variables en EasyPanel**
2. **Logs completos del contenedor** (`docker-compose logs`)
3. **Resultado del script de verificación** (`check-env.php`)
4. **Versión de EasyPanel** que estás usando
5. **Navegador y consola de desarrollador** (errores JavaScript)

### Comandos de Debugging Útiles

```bash
# Ver todas las variables de entorno
printenv | grep -E "(APP|DB|REDIS|MAIL)"

# Verificar PHP y extensiones
php -v
php -m | grep -E "(pdo|redis|ioncube)"

# Verificar conectividad de red
netstat -tlnp | grep -E "(3306|6379|80)"

# Verificar logs de Laravel
tail -f storage/logs/laravel.log
```

---

**¡Con esta configuración, tu sistema CPS estará completamente optimizado para EasyPanel!** 🎉