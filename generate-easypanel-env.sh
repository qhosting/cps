#!/bin/bash

# ==============================================================================
# GENERADOR DE ARCHIVO .ENV PARA EASYPANEL - SISTEMA CPS
# ==============================================================================
# 
# Este script genera automáticamente un archivo .env optimizado para EasyPanel
# combinando las variables automáticas de EasyPanel con las configuraciones
# específicas del sistema CPS.
#
# Uso: ./generate-easypanel-env.sh
# ==============================================================================

set -e  # Salir si hay errores

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_message() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✅ SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[⚠️  WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[❌ ERROR]${NC} $1"
}

print_message "Iniciando generación de archivo .env para EasyPanel..."

# Verificar si estamos en un entorno EasyPanel
if [ "$EASYPANEL" = "true" ]; then
    print_success "Detectado entorno EasyPanel"
    print_message "Proyecto: $EASYPANEL_PROJECT"
    print_message "Dominio: $EASYPANEL_DOMAIN"
else
    print_warning "No se detectó EasyPanel - usando variables de desarrollo"
fi

# Generar APP_KEY si no existe o es inválido
generate_app_key() {
    if [ -z "$APP_KEY" ] || [[ "$APP_KEY" == *"GENERATE_YOUR_APP_KEY_HERE"* ]]; then
        print_message "Generando APP_KEY..."
        # Generar usando openssl
        APP_KEY="base64:$(openssl rand -base64 32)"
        print_success "APP_KEY generado: ${APP_KEY:0:20}..."
    else
        print_success "APP_KEY ya configurado"
    fi
}

# Configurar APP_URL si no está definida
setup_app_url() {
    if [ -z "$APP_URL" ]; then
        if [ -n "$EASYPANEL_DOMAIN" ]; then
            APP_URL="https://${EASYPANEL_DOMAIN}/"
            print_success "APP_URL configurada: $APP_URL"
        else
            APP_URL="http://localhost/"
            print_warning "Usando APP_URL por defecto: $APP_URL"
        fi
    fi
}

# Función para solicitar configuraciones del usuario
ask_for_config() {
    echo
    print_message "=== CONFIGURACIÓN INTERACTIVA DEL SISTEMA CPS ==="
    
    # Configuración básica
    read -p "Nombre de la aplicación [CPS]: " APP_NAME_INPUT
    APP_NAME=${APP_NAME_INPUT:-CPS}
    
    read -p "Versión de la aplicación [120.55.1]: " APP_VERSION_INPUT
    APP_VERSION=${APP_VERSION_INPUT:-120.55.1}
    
    read -p "Clave de licencia de CPS: " APP_LICENSE
    if [ -z "$APP_LICENSE" ]; then
        print_error "La clave de licencia es obligatoria"
        exit 1
    fi
    
    read -p "Token API: " API_TOKEN
    if [ -z "$API_TOKEN" ]; then
        print_error "El token API es obligatorio"
        exit 1
    fi
    
    # Configuración de Stripe (opcional)
    echo
    print_message "=== CONFIGURACIÓN DE STRIPE (OPCIONAL) ==="
    read -p "Stripe Public Key [dejar vacío para omitir]: " STRIPE_KEY
    read -p "Stripe Secret Key [dejar vacío para omitir]: " STRIPE_SECRET
    read -p "Stripe Webhook Secret [dejar vacío para omitir]: " STRIPE_WEBHOOK_SECRET
    
    # Configuración de Email
    echo
    print_message "=== CONFIGURACIÓN DE EMAIL ==="
    read -p "Servidor SMTP: " MAIL_HOST
    if [ -z "$MAIL_HOST" ]; then
        print_error "El servidor SMTP es obligatorio"
        exit 1
    fi
    
    read -p "Puerto SMTP [587]: " MAIL_PORT_INPUT
    MAIL_PORT=${MAIL_PORT_INPUT:-587}
    
    read -p "Usuario SMTP: " MAIL_USERNAME
    if [ -z "$MAIL_USERNAME" ]; then
        print_error "El usuario SMTP es obligatorio"
        exit 1
    fi
    
    read -s -p "Contraseña SMTP: " MAIL_PASSWORD
    echo
    if [ -z "$MAIL_PASSWORD" ]; then
        print_error "La contraseña SMTP es obligatoria"
        exit 1
    fi
    
    read -p "Email remitente [noreply@localhost]: " MAIL_FROM_ADDRESS_INPUT
    MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS_INPUT:-noreply@localhost}
    
    read -p "Nombre del remitente [CPS System]: " MAIL_FROM_NAME_INPUT
    MAIL_FROM_NAME=${MAIL_FROM_NAME_INPUT:-"CPS System"}
    
    # URLs de licenciamiento
    echo
    print_message "=== URLS DE LICENCIAMIENTO ==="
    read -p "URL del módulo de servidor [https://servidor-licencias.com/syslicensing.zip]: " SYS_LIC_SERVER_MODULE_INPUT
    read -p "URL del módulo addon [https://servidor-licencias.com/licensing.zip]: " SYS_LIC_ADDON_MODULE_INPUT
    read -p "URL de API de licencias [https://servidor-licencias.com/]: " SYS_LIC_API_URL_INPUT
}

# Generar el archivo .env
generate_env_file() {
    print_message "Generando archivo .env..."
    
    cat > .env << EOF
# ==============================================================================
# CONFIGURACIÓN DEL SISTEMA CPS PARA EASYPANEL
# Generado automáticamente el $(date)
# ==============================================================================

# === CONFIGURACIÓN AUTOMÁTICA DE EASYPANEL ===
EASYPANEL=${EASYPANEL:-false}
EASYPANEL_PROJECT=${EASYPANEL_PROJECT}
EASYPANEL_DOMAIN=${EASYPANEL_DOMAIN}
HOST=${HOST:-0.0.0.0}
PORT=${PORT:-80}

# === CONFIGURACIÓN DE LA APLICACIÓN ===
APP_NAME=${APP_NAME:-CPS}
APP_ENV=${APP_ENV:-production}
APP_KEY=${APP_KEY}
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=${APP_URL}
APP_LICENSE=${APP_LICENSE}
APP_VERSION=${APP_VERSION:-120.55.1}

# === CONFIGURACIÓN DE BASE DE DATOS ===
DB_CONNECTION=mysql
DB_HOST=${DB_HOST:-mysql}
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-cps_database}
DB_USERNAME=${DB_USERNAME:-cps_user}
DB_PASSWORD=${DB_PASSWORD:-cps_password_123}

# === CONFIGURACIÓN DE REDIS ===
REDIS_HOST=${REDIS_HOST:-redis}
REDIS_PORT=${REDIS_PORT:-6379}
REDIS_PASSWORD=${REDIS_PASSWORD:-null}

# === CONFIGURACIÓN DE EMAIL ===
MAIL_DRIVER=smtp
MAIL_HOST=${MAIL_HOST}
MAIL_PORT=${MAIL_PORT:-587}
MAIL_USERNAME=${MAIL_USERNAME}
MAIL_PASSWORD=${MAIL_PASSWORD}
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS}
MAIL_FROM_NAME=${MAIL_FROM_NAME}

# === CONFIGURACIÓN DE CACHÉ Y SESIONES ===
CACHE_DRIVER=redis
SESSION_DRIVER=redis
SESSION_LIFETIME=120
SESSION_SECURE_COOKIE=true
SESSION_HTTP_ONLY=true

# === CONFIGURACIÓN DE COLAS ===
QUEUE_CONNECTION=redis

# === CONFIGURACIÓN DE LOGGING ===
LOG_CHANNEL=stack
LOG_LEVEL=notice

# === CONFIGURACIÓN DE BROADCASTING ===
BROADCAST_DRIVER=log

# === CONFIGURACIÓN DE PAGOS - STRIPE ===
EOF

    # Agregar configuración de Stripe si se proporcionó
    if [ -n "$STRIPE_KEY" ] && [ -n "$STRIPE_SECRET" ]; then
        cat >> .env << EOF
STRIPE_KEY=${STRIPE_KEY}
STRIPE_SECRET=${STRIPE_SECRET}
EOF
        if [ -n "$STRIPE_WEBHOOK_SECRET" ]; then
            echo "STRIPE_WEBHOOK_SECRET=${STRIPE_WEBHOOK_SECRET}" >> .env
        fi
        print_success "Configuración de Stripe incluida"
    else
        print_warning "Stripe no configurado - saltar variables"
        cat >> .env << EOF
# STRIPE_KEY=pk_live_tu_clave_publica_stripe
# STRIPE_SECRET=sk_live_tu_clave_secreta_stripe
# STRIPE_WEBHOOK_SECRET=whsec_tu_webhook_secret
EOF
    fi

    # Agregar URLs de licenciamiento si se proporcionaron
    cat >> .env << EOF

# === URLS DE LICENCIAMIENTO ===
EOF

    if [ -n "$SYS_LIC_SERVER_MODULE_INPUT" ]; then
        echo "SYS_LIC_SERVER_MODULE=${SYS_LIC_SERVER_MODULE_INPUT}" >> .env
    else
        echo "# SYS_LIC_SERVER_MODULE=https://servidor-licencias.com/syslicensing.zip" >> .env
    fi
    
    if [ -n "$SYS_LIC_ADDON_MODULE_INPUT" ]; then
        echo "SYS_LIC_ADDON_MODULE=${SYS_LIC_ADDON_MODULE_INPUT}" >> .env
    else
        echo "# SYS_LIC_ADDON_MODULE=https://servidor-licencias.com/licensing.zip" >> .env
    fi
    
    if [ -n "$SYS_LIC_API_URL_INPUT" ]; then
        echo "SYS_LIC_API_URL=${SYS_LIC_API_URL_INPUT}" >> .env
    else
        echo "# SYS_LIC_API_URL=https://servidor-licencias.com/" >> .env
    fi
    
    if [ -n "$API_TOKEN" ]; then
        echo "API_TOKEN=${API_TOKEN}" >> .env
    else
        echo "# API_TOKEN=tu_token_api_aqui" >> .env
    fi

    # Agregar configuración de seguridad al final
    cat >> .env << EOF

# === CONFIGURACIÓN DE SEGURIDAD ===
SESSION_COOKIE_SECURE=true
SESSION_COOKIE_HTTPONLY=true
SESSION_USE_STRICT_MODE=1

# === CONFIGURACIÓN DE PERFORMANCE ===
OPACACHE_ENABLE=1
OPACACHE_MEMORY_CONSUMPTION=128
OPACACHE_INTERNED_STRINGS_BUFFER=8
OPACACHE_MAX_ACCELERATED_FILES=4000

# === URLs DE INSTALACIÓN (opcional) ===
# PRE_SH_SCRIPT_URL=https://mirror.tu-servidor.com/pre.sh
# SYS_LIC_ZIP_URL=https://tu-servidor.com/syslicensing.zip

EOF

    print_success "Archivo .env generado exitosamente"
}

# Función para validar el archivo .env generado
validate_env_file() {
    print_message "Validando archivo .env generado..."
    
    # Variables críticas que deben estar presentes
    critical_vars=("APP_NAME" "APP_KEY" "APP_LICENSE" "DB_HOST" "DB_DATABASE" "MAIL_HOST")
    missing_vars=()
    
    for var in "${critical_vars[@]}"; do
        if ! grep -q "^${var}=" .env || grep -q "^${var}=\s*$" .env; then
            missing_vars+=("$var")
        fi
    done
    
    if [ ${#missing_vars[@]} -gt 0 ]; then
        print_error "Variables críticas faltantes o vacías:"
        for var in "${missing_vars[@]}"; do
            echo "  - $var"
        done
        exit 1
    else
        print_success "Todas las variables críticas están configuradas"
    fi
}

# Función para mostrar el resumen
show_summary() {
    echo
    print_message "=== RESUMEN DE CONFIGURACIÓN ==="
    echo "✅ Archivo .env generado: .env"
    echo "✅ Proyecto: $APP_NAME"
    echo "✅ Entorno: $APP_ENV"
    echo "✅ APP_URL: $APP_URL"
    echo "✅ Base de datos: $DB_DATABASE"
    echo "✅ Redis: $REDIS_HOST:$REDIS_PORT"
    echo "✅ Email: $MAIL_HOST:$MAIL_PORT"
    
    if [ -n "$STRIPE_KEY" ]; then
        echo "✅ Stripe: Configurado"
    else
        echo "⚠️  Stripe: No configurado"
    fi
    
    echo
    print_message "=== PRÓXIMOS PASOS ==="
    echo "1. Revisar y ajustar el archivo .env si es necesario"
    echo "2. Configurar las variables en EasyPanel (si usas variables manuales)"
    echo "3. Reiniciar el contenedor: docker-compose restart"
    echo "4. Verificar los logs: docker-compose logs -f"
    echo "5. Probar la aplicación en tu navegador"
    echo
    print_success "Configuración completada exitosamente!"
}

# Función principal
main() {
    print_message "Iniciando generador de configuración para EasyPanel..."
    
    # Generar APP_KEY
    generate_app_key
    
    # Configurar APP_URL
    setup_app_url
    
    # Solicitar configuraciones al usuario
    ask_for_config
    
    # Generar archivo .env
    generate_env_file
    
    # Validar archivo generado
    validate_env_file
    
    # Mostrar resumen
    show_summary
}

# Verificar dependencias
if ! command -v openssl &> /dev/null; then
    print_error "openssl no está instalado. Instálalo para generar APP_KEY."
    exit 1
fi

# Ejecutar función principal
main "$@"