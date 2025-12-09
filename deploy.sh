#!/bin/bash

# =============================================================================
# SCRIPT DE DESPLIEGUE AUTOMÁTICO PARA SISTEMA CPS
# Opción D - Despliegue Automático Completo
# =============================================================================

set -euo pipefail

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración
APP_NAME="CPS License Management"
LOG_FILE="/var/log/cps-deploy.log"
BACKUP_DIR="/opt/backups/cps"
DATA_DIR="/var/www/system"
CONFIG_FILE="/etc/cps/config.conf"

# Funciones auxiliares
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}" | tee -a "$LOG_FILE"
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}[INFO] $1${NC}" | tee -a "$LOG_FILE"
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "Este script debe ejecutarse como root"
    fi
}

install_dependencies() {
    log "Instalando dependencias del sistema..."
    
    # Actualizar sistema
    apt-get update && apt-get upgrade -y
    
    # Instalar Docker y Docker Compose
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    usermod -aG docker $USER
    
    # Instalar dependencias adicionales
    apt-get install -y \
        curl \
        wget \
        git \
        unzip \
        htop \
        tree \
        fail2ban \
        ufw \
        nginx
    
    log "Dependencias instaladas correctamente"
}

setup_firewall() {
    log "Configurando firewall..."
    
    ufw --force reset
    ufw default deny incoming
    ufw default allow outgoing
    
    # Permitir SSH, HTTP, HTTPS
    ufw allow ssh
    ufw allow 80/tcp
    ufw allow 443/tcp
    
    # Permitir puertos específicos de la aplicación si es necesario
    # ufw allow 8080/tcp  # API port
    # ufw allow 8081/tcp  # WebSocket port
    
    ufw --force enable
    
    log "Firewall configurado correctamente"
}

configure_fail2ban() {
    log "Configurando Fail2Ban..."
    
    cat > /etc/fail2ban/jail.local << EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3

[nginx-http-auth]
enabled = true
filter = nginx-http-auth
logpath = /var/log/nginx/error.log
maxretry = 3

[nginx-limit-req]
enabled = true
filter = nginx-limit-req
logpath = /var/log/nginx/error.log
maxretry = 10
EOF

    systemctl enable fail2ban
    systemctl restart fail2ban
    
    log "Fail2Ban configurado correctamente"
}

setup_ssl() {
    local domain="$1"
    local email="$2"
    
    log "Configurando SSL con Let's Encrypt para $domain..."
    
    # Instalar Certbot
    apt-get install -y certbot python3-certbot-nginx
    
    # Obtener certificado SSL
    certbot --nginx -d "$domain" --email "$email" --agree-tos --non-interactive
    
    # Configurar renovación automática
    crontab -l | grep -q "certbot renew" || (crontab -l; echo "0 12 * * * /usr/bin/certbot renew --quiet") | crontab -
    
    log "SSL configurado correctamente"
}

create_directories() {
    log "Creando estructura de directorios..."
    
    mkdir -p "$BACKUP_DIR"
    mkdir -p "$DATA_DIR"
    mkdir -p "$(dirname "$CONFIG_FILE")"
    mkdir -p /var/log/cps
    mkdir -p /etc/cps
    
    # Establecer permisos
    chown -R www-data:www-data "$DATA_DIR"
    chown -R www-data:www-data /var/log/cps
    
    log "Directorios creados correctamente"
}

configure_environment() {
    local domain="$1"
    local db_name="$2"
    local db_user="$3"
    local db_pass="$4"
    
    log "Configurando variables de entorno..."
    
    # Generar APP_KEY si no existe
    if [[ ! -f "$DATA_DIR/.env" ]]; then
        cp "$DATA_DIR/.env.example" "$DATA_DIR/.env"
        php artisan key:generate --force
    fi
    
    # Actualizar configuración
    sed -i "s/APP_URL=.*/APP_URL=https:\/\/$domain/" "$DATA_DIR/.env"
    sed -i "s/DB_DATABASE=.*/DB_DATABASE=$db_name/" "$DATA_DIR/.env"
    sed -i "s/DB_USERNAME=.*/DB_USERNAME=$db_user/" "$DATA_DIR/.env"
    sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=$db_pass/" "$DATA_DIR/.env"
    
    # Configurar Redis si está disponible
    sed -i "s/REDIS_HOST=.*/REDIS_HOST=127.0.0.1/" "$DATA_DIR/.env"
    
    # Optimizaciones para producción
    sed -i "s/APP_ENV=.*/APP_ENV=production/" "$DATA_DIR/.env"
    sed -i "s/APP_DEBUG=.*/APP_DEBUG=false/" "$DATA_DIR/.env"
    
    log "Variables de entorno configuradas"
}

deploy_application() {
    log "Desplegando aplicación..."
    
    cd "$DATA_DIR"
    
    # Limpiar caché
    php artisan cache:clear || true
    php artisan config:clear || true
    php artisan view:clear || true
    
    # Actualizar dependencias
    composer install --optimize-autoloader --no-dev
    
    # Ejecutar migraciones
    php artisan migrate --force
    
    # Optimizar para producción
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    
    log "Aplicación desplegada correctamente"
}

configure_nginx() {
    local domain="$1"
    
    log "Configurando Nginx..."
    
    cat > /etc/nginx/sites-available/cps << EOF
server {
    listen 80;
    server_name $domain;
    return 301 https://\$server_name\$request_uri;
}

server {
    listen 443 ssl http2;
    server_name $domain;
    
    root $DATA_DIR/public;
    index index.php index.html index.htm;
    
    # SSL Configuration
    ssl_certificate /etc/letsencrypt/live/$domain/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$domain/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;
    
    # Security Headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
    
    # Gzip Compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied expired no-cache no-store private must-revalidate auth;
    gzip_types
        text/plain
        text/css
        text/xml
        text/javascript
        application/x-javascript
        application/xml+rss
        application/javascript
        application/json;
    
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }
    
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    
    error_page 404 /index.php;
    
    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_hide_header X-Powered-By;
    }
    
    location ~ /\.(?!well-known).* {
        deny all;
    }
    
    # Laravel specific optimizations
    location ~ ^/(css|js|img|fonts)/ {
        expires 1y;
        add_header Cache-Control "public, immutable";
        access_log off;
    }
}
EOF

    # Activar sitio
    ln -sf /etc/nginx/sites-available/cps /etc/nginx/sites-enabled/
    rm -f /etc/nginx/sites-enabled/default
    
    # Probar configuración
    nginx -t
    
    systemctl reload nginx
    
    log "Nginx configurado correctamente"
}

setup_monitoring() {
    log "Configurando monitoreo..."
    
    # Script de monitoreo
    cat > /usr/local/bin/cps-monitor.sh << 'EOF'
#!/bin/bash

APP_DIR="/var/www/system"
LOG_FILE="/var/log/cps-monitor.log"
ERROR_LIMIT=10
TIME_WINDOW=300  # 5 minutos

check_disk_space() {
    local usage=$(df "$APP_DIR" | awk 'NR==2 {print $5}' | sed 's/%//')
    if [[ $usage -gt 90 ]]; then
        echo "$(date): Disk usage is ${usage}%" >> "$LOG_FILE"
        # Enviar alerta (implementar según necesidades)
    fi
}

check_nginx() {
    if ! systemctl is-active --quiet nginx; then
        echo "$(date): Nginx is down, restarting..." >> "$LOG_FILE"
        systemctl restart nginx
    fi
}

check_php_fpm() {
    if ! systemctl is-active --quiet php8.3-fpm; then
        echo "$(date): PHP-FPM is down, restarting..." >> "$LOG_FILE"
        systemctl restart php8.3-fpm
    fi
}

check_laravel_log() {
    local error_count=$(tail -n 100 "$APP_DIR/storage/logs/laravel.log" 2>/dev/null | grep -c "ERROR\|CRITICAL" || echo "0")
    if [[ $error_count -gt $ERROR_LIMIT ]]; then
        echo "$(date): High error count in Laravel log: $error_count" >> "$LOG_FILE"
        # Enviar alerta
    fi
}

main() {
    check_disk_space
    check_nginx
    check_php_fpm
    check_laravel_log
}

main "$@"
EOF

    chmod +x /usr/local/bin/cps-monitor.sh
    
    # Agregar a crontab
    (crontab -l 2>/dev/null; echo "*/5 * * * * /usr/local/bin/cps-monitor.sh") | crontab -
    
    log "Monitoreo configurado correctamente"
}

setup_backup() {
    log "Configurando backups automáticos..."
    
    cat > /usr/local/bin/cps-backup.sh << EOF
#!/bin/bash

BACKUP_DIR="$BACKUP_DIR"
DATE=\$(date +%Y%m%d_%H%M%S)
APP_DIR="$DATA_DIR"
DB_NAME="cps_database"
DB_USER="username"
DB_PASS="password"

# Crear backup de la base de datos
mysqldump -u\$DB_USER -p\$DB_PASS \$DB_NAME > "\$BACKUP_DIR/db_backup_\$DATE.sql"

# Crear backup de archivos
tar -czf "\$BACKUP_DIR/files_backup_\$DATE.tar.gz" -C "\$APP_DIR" .

# Limpiar backups antiguos (mantener últimos 30 días)
find "\$BACKUP_DIR" -name "*.sql" -mtime +30 -delete
find "\$BACKUP_DIR" -name "*.tar.gz" -mtime +30 -delete

echo "\$(date): Backup completed successfully" >> /var/log/cps-backup.log
EOF

    chmod +x /usr/local/bin/cps-backup.sh
    
    # Configurar cron para backups diarios
    (crontab -l 2>/dev/null; echo "0 2 * * * /usr/local/bin/cps-backup.sh") | crontab -
    
    log "Backups configurados correctamente"
}

setup_maintenance() {
    log "Configurando modo mantenimiento..."
    
    cat > /usr/local/bin/cps-maintenance.sh << 'EOF'
#!/bin/bash

APP_DIR="/var/www/system"
LOG_FILE="/var/log/cps-maintenance.log"

case "$1" in
    enable)
        if [[ ! -f "$APP_DIR/storage/framework/down" ]]; then
            touch "$APP_DIR/storage/framework/down"
            echo "$(date): Maintenance mode enabled" >> "$LOG_FILE"
        fi
        ;;
    disable)
        if [[ -f "$APP_DIR/storage/framework/down" ]]; then
            rm -f "$APP_DIR/storage/framework/down"
            echo "$(date): Maintenance mode disabled" >> "$LOG_FILE"
        fi
        ;;
    *)
        echo "Usage: $0 {enable|disable}"
        exit 1
        ;;
esac
EOF

    chmod +x /usr/local/bin/cps-maintenance.sh
    
    log "Modo mantenimiento configurado"
}

main() {
    log "Iniciando despliegue automático de $APP_NAME"
    
    # Verificaciones previas
    check_root
    
    # Parámetros
    DOMAIN="${1:-cps.qhosting.net}"
    EMAIL="${2:-admin@qhosting.net}"
    DB_NAME="${3:-cps_database}"
    DB_USER="${4:-username}"
    DB_PASS="${5:-secure_password_123}"
    
    info "Configuración:"
    info "  - Dominio: $DOMAIN"
    info "  - Email: $EMAIL"
    info "  - Base de datos: $DB_NAME"
    
    # Instalación y configuración
    install_dependencies
    setup_firewall
    configure_fail2ban
    create_directories
    setup_ssl "$DOMAIN" "$EMAIL"
    configure_environment "$DOMAIN" "$DB_NAME" "$DB_USER" "$DB_PASS"
    configure_nginx "$DOMAIN"
    setup_monitoring
    setup_backup
    setup_maintenance
    
    # Desplegar aplicación
    deploy_application
    
    log "¡Despliegue completado exitosamente!"
    info "Accede a tu aplicación en: https://$DOMAIN"
    info "Logs disponibles en: $LOG_FILE"
}

# Manejo de señales
trap 'error "Script interrumpido"' INT TERM

# Ejecutar función principal
main "$@"