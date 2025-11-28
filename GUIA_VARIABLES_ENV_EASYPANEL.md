# Guía Completa: Variables de Entorno en EasyPanel para CPS

## ¿Qué son las Variables de Entorno de EasyPanel?

EasyPanel proporciona variables de entorno automáticas que puedes usar en tu aplicación Docker. Estas variables te permiten acceder a información del servidor y configuraciones sin hardcodear valores.

## Variables de Entorno Automáticas de EasyPanel

### Variables del Sistema
```bash
EASYPANEL=true                    # Identifica que la app está en EasyPanel
EASYPANEL_HOST=server.easypanel.io # Host del servidor EasyPanel
EASYPANEL_PROJECT=cps_qhosting    # Nombre del proyecto
EASYPANEL_DOMAIN=tu-dominio.com   # Dominio configurado
```

### Variables de Red y Puertos
```bash
HOST=0.0.0.0                     # IP del contenedor
PORT=80                          # Puerto HTTP
HOST_HTTPS=0.0.0.0               # IP HTTPS (si SSL está habilitado)
PORT_HTTPS=443                   # Puerto HTTPS (si SSL está habilitado)
```

### Variables de Base de Datos
```bash
DB_HOST=mysql                    # Host de base de datos interno
DB_PORT=3306                     # Puerto MySQL
DB_DATABASE=cps_database         # Base de datos del proyecto
DB_USERNAME=cps_user             # Usuario de la base de datos
DB_PASSWORD=cps_password_123     # Contraseña de la base de datos
```

### Variables de Redis
```bash
REDIS_HOST=redis                 # Host de Redis
REDIS_PORT=6379                  # Puerto de Redis
REDIS_PASSWORD=null              # Contraseña de Redis (usualmente null)
```

## Variables de Entorno Específicas para tu Sistema CPS

### Configuración Básica del Sistema
```bash
# Estas deben configurarse manualmente en EasyPanel
APP_NAME=CPS
APP_ENV=production
APP_KEY=base64:GENERATE_YOUR_APP_KEY_HERE
APP_DEBUG=false
APP_URL=https://tu-dominio.com/

# Configuración específica de CPS
APP_LICENSE=license_tu_clave_de_licencia
APP_VERSION=120.55.1
API_TOKEN=tu_token_api_aqui

# URLs del servidor de licencias
SYS_LIC_SERVER_MODULE=https://tu-servidor.com/syslicensing.zip
SYS_LIC_ADDON_MODULE=https://tu-servidor.com/licensing.zip
SYS_LIC_API_URL=https://tu-servidor.com/
```

### Configuración de Pagos
```bash
# Stripe (si usas este procesador de pagos)
STRIPE_KEY=pk_live_tu_clave_publica_stripe
STRIPE_SECRET=sk_live_tu_clave_secreta_stripe
STRIPE_WEBHOOK_SECRET=whsec_tu_webhook_secret

# PayPal (opcional)
PAYPAL_CLIENT_ID=tu_client_id_paypal
PAYPAL_CLIENT_SECRET=tu_client_secret_paypal
```

### Configuración de Email
```bash
# SMTP Configuration
MAIL_DRIVER=smtp
MAIL_HOST=smtp.tu-proveedor-email.com
MAIL_PORT=587
MAIL_USERNAME=tu-email@dominio.com
MAIL_PASSWORD=tu_password_email
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@tu-dominio.com
MAIL_FROM_NAME="CPS System"
```

## Cómo Configurar las Variables en EasyPanel

### Paso 1: Acceder a la Configuración del Proyecto
1. Ve a tu proyecto en EasyPanel: **CRM → cps_qhosting**
2. Haz clic en **Configuración**
3. Busca la sección **"Variables de Entorno"** o **"Environment Variables"**

### Paso 2: Agregar Variables Manualmente
En EasyPanel, puedes agregar variables de entorno de esta forma:

```bash
# Variable → Valor
APP_NAME → CPS
APP_ENV → production
APP_KEY → base64:GENERATE_YOUR_APP_KEY_HERE
APP_LICENSE → license_tu_clave_de_licencia
API_TOKEN → tu_token_api_aqui
STRIPE_KEY → pk_live_tu_clave_publica_stripe
STRIPE_SECRET → sk_live_tu_clave_secreta_stripe
MAIL_HOST → smtp.tu-proveedor-email.com
MAIL_USERNAME → tu-email@dominio.com
MAIL_PASSWORD → tu_password_email
```

### Paso 3: Usar Variables en tu Dockerfile
Modifica tu `Dockerfile` para usar las variables de EasyPanel:

```dockerfile
FROM php:8.1-fpm

# Configurar variables de entorno desde EasyPanel
ENV APP_NAME=${APP_NAME:-CPS}
ENV APP_ENV=${APP_ENV:-production}
ENV APP_DEBUG=${APP_DEBUG:-false}

# Otras configuraciones
RUN echo "EasyPanel Host: $EASYPANEL_HOST" >> /var/log/app.log
RUN echo "Project: $EASYPANEL_PROJECT" >> /var/log/app.log
```

### Paso 4: Modificar docker-compose.yml para EasyPanel
Crea una versión específica para EasyPanel que use las variables automáticas:

```yaml
version: '3.8'

services:
  app:
    build: .
    container_name: cps_app
    ports:
      - "${PORT:-80}:80"
    environment:
      - APP_ENV=${APP_ENV:-production}
      - APP_DEBUG=${APP_DEBUG:-false}
      - DB_HOST=${DB_HOST:-mysql}
      - DB_DATABASE=${DB_DATABASE:-cps_database}
      - DB_USERNAME=${DB_USERNAME:-cps_user}
      - DB_PASSWORD=${DB_PASSWORD:-cps_password_123}
      - REDIS_HOST=${REDIS_HOST:-redis}
      - REDIS_PORT=${REDIS_PORT:-6379}
    depends_on:
      - mysql
      - redis
    networks:
      - cps_network

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD:-cps_password_123}
      MYSQL_DATABASE: ${DB_DATABASE:-cps_database}
      MYSQL_USER: ${DB_USERNAME:-cps_user}
      MYSQL_PASSWORD: ${DB_PASSWORD:-cps_password_123}

  redis:
    image: redis:7-alpine
    # Redis no necesita variables especiales

networks:
  cps_network:
    driver: bridge
```

## Ejemplo Completo de Configuración .env para EasyPanel

Crea un archivo `.env.easypanel` que combine las variables automáticas con las manuales:

```bash
# === VARIABLES AUTOMÁTICAS DE EASYPANEL ===
EASYPANEL=true
EASYPANEL_PROJECT=${EASYPANEL_PROJECT}
EASYPANEL_DOMAIN=${EASYPANEL_DOMAIN}
HOST=${HOST}
PORT=${PORT}

# === VARIABLES DE BASE DE DATOS ===
DB_CONNECTION=mysql
DB_HOST=${DB_HOST:-mysql}
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-cps_database}
DB_USERNAME=${DB_USERNAME:-cps_user}
DB_PASSWORD=${DB_PASSWORD:-cps_password_123}

# === VARIABLES DE REDIS ===
REDIS_HOST=${REDIS_HOST:-redis}
REDIS_PORT=${REDIS_PORT:-6379}
REDIS_PASSWORD=${REDIS_PASSWORD:-null}

# === CONFIGURACIÓN DE LA APLICACIÓN ===
APP_NAME=CPS
APP_ENV=production
APP_KEY=base64:GENERATE_YOUR_APP_KEY_HERE
APP_DEBUG=false
APP_URL=https://${EASYPANEL_DOMAIN}/
APP_LICENSE=license_tu_clave_de_licencia
APP_VERSION=120.55.1

# === CONFIGURACIÓN DE PAGOS ===
STRIPE_KEY=pk_live_tu_clave_publica_stripe
STRIPE_SECRET=sk_live_tu_clave_secreta_stripe

# === CONFIGURACIÓN DE EMAIL ===
MAIL_DRIVER=smtp
MAIL_HOST=smtp.tu-proveedor-email.com
MAIL_PORT=587
MAIL_USERNAME=tu-email@dominio.com
MAIL_PASSWORD=tu_password_email
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@${EASYPANEL_DOMAIN}
MAIL_FROM_NAME="CPS System"

# === CONFIGURACIÓN DE PERFORMANCE ===
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
LOG_CHANNEL=stack

# === CONFIGURACIÓN DE SEGURIDAD ===
SESSION_LIFETIME=120
SESSION_SECURE_COOKIE=true
SESSION_HTTP_ONLY=true
```

## Script de Configuración Automática

Crea un script `setup-easypanel-env.sh` que se ejecute durante el build:

```bash
#!/bin/bash

echo "=== Configurando variables de entorno para EasyPanel ==="

# Generar APP_KEY si no existe
if [ -z "$APP_KEY" ] || [[ "$APP_KEY" == *"GENERATE_YOUR_APP_KEY_HERE"* ]]; then
    APP_KEY=$(php artisan key:generate --show)
    echo "Generated APP_KEY: $APP_KEY"
fi

# Configurar URL de la aplicación
if [ -n "$EASYPANEL_DOMAIN" ]; then
    APP_URL="https://${EASYPANEL_DOMAIN}/"
    echo "Set APP_URL to: $APP_URL"
fi

# Crear archivo .env
cat > .env << EOF
APP_NAME=${APP_NAME:-CPS}
APP_ENV=${APP_ENV:-production}
APP_KEY=${APP_KEY}
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=${APP_URL}
APP_LICENSE=${APP_LICENSE}
APP_VERSION=${APP_VERSION:-120.55.1}

DB_CONNECTION=mysql
DB_HOST=${DB_HOST:-mysql}
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-cps_database}
DB_USERNAME=${DB_USERNAME:-cps_user}
DB_PASSWORD=${DB_PASSWORD:-cps_password_123}

REDIS_HOST=${REDIS_HOST:-redis}
REDIS_PORT=${REDIS_PORT:-6379}
REDIS_PASSWORD=${REDIS_PASSWORD:-null}

MAIL_DRIVER=smtp
MAIL_HOST=${MAIL_HOST}
MAIL_PORT=${MAIL_PORT:-587}
MAIL_USERNAME=${MAIL_USERNAME}
MAIL_PASSWORD=${MAIL_PASSWORD}
MAIL_ENCRYPTION=${MAIL_ENCRYPTION:-tls}
MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS}
MAIL_FROM_NAME=${MAIL_FROM_NAME:-"CPS System"}

CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
LOG_CHANNEL=stack
EOF

echo "=== Archivo .env creado exitosamente ==="
```

## Variables de Entorno Específicas para Producción

### Seguridad
```bash
APP_DEBUG=false
LOG_LEVEL=notice
SESSION_SECURE_COOKIE=true
SESSION_HTTP_ONLY=true
FORCE_HTTPS=true
```

### Performance
```bash
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
OPACACHE_ENABLE=true
```

### Monitoreo
```bash
LOG_CHANNEL=stack
LOG_LEVEL=notice
APP_DEBUG=false
```

## Verificación de Variables

Crea un archivo `check-env.php` para verificar que las variables estén configuradas correctamente:

```php
<?php
echo "=== VERIFICACIÓN DE VARIABLES DE ENTORNO ===\n\n";

// Variables críticas
$critical_vars = [
    'APP_NAME',
    'APP_ENV',
    'APP_KEY',
    'DB_HOST',
    'DB_DATABASE',
    'DB_USERNAME',
    'DB_PASSWORD',
    'REDIS_HOST'
];

foreach ($critical_vars as $var) {
    $value = getenv($var) ?: 'NO DEFINIDA';
    $status = getenv($var) ? '✅' : '❌';
    echo "$status $var: $value\n";
}

echo "\n=== VARIABLES DE EASYPANEL ===\n";
$easypanel_vars = ['EASYPANEL', 'EASYPANEL_PROJECT', 'EASYPANEL_DOMAIN'];
foreach ($easypanel_vars as $var) {
    $value = getenv($var) ?: 'NO DISPONIBLE';
    echo "📦 $var: $value\n";
}
```

## Solución de Problemas

### Problema: Variables no se cargan
1. Verifica que estén configuradas en el panel de EasyPanel
2. Reinicia el contenedor después de cambiar variables
3. Revisa los logs del contenedor

### Problema: Base de datos no conecta
1. Verifica las variables DB_* en EasyPanel
2. Asegúrate de que MySQL esté corriendo
3. Comprueba las credenciales

### Problema: Redis no funciona
1. Verifica REDIS_HOST y REDIS_PORT
2. Comprueba que Redis esté corriendo
3. Revisa la conectividad de red entre contenedores

## Próximos Pasos

1. **Configurar las variables en EasyPanel** usando la interfaz web
2. **Actualizar tu Dockerfile** para usar variables de EasyPanel
3. **Probar la configuración** haciendo un nuevo despliegue
4. **Monitorear logs** para verificar que todo funcione correctamente

---

**Nota:** Las variables automáticas de EasyPanel están disponibles desde el momento en que se inicia el contenedor, mientras que las variables manuales pueden tardar unos segundos en aparecer.