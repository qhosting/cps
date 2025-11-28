# Configuración Específica para EasyPanel - Sistema CPS

## Configuración del Servidor Web

### Configuración de .htaccess (ya incluido en el proyecto)

El archivo `.htaccess` ya está configurado en la carpeta `public/` del proyecto con:

- Reescritura de URLs para Laravel
- Protección de archivos sensibles
- Configuración de headers de seguridad
- Compresión GZIP

### Configuración de PHP en EasyPanel

#### Versión PHP Requerida
- **Mínimo**: PHP 8.0
- **Recomendado**: PHP 8.1 o PHP 8.2

#### Extensiones PHP Requeridas

1. **ionCube Loader** (CRÍTICO - Sistema protegido)
2. **MySQLi** - Para conexión a base de datos
3. **PDO** - Para ORM de Laravel
4. **Redis** - Para caché y sesiones
5. **GD** o **Imagick** - Para manipulación de imágenes
6. **cURL** - Para APIs externas
7. **OpenSSL** - Para HTTPS y cifrado
8. **Zip** - Para archivos comprimidos
9. **XML** - Para procesamiento de XML
10. **JSON** - Para APIs JSON
11. **Mbstring** - Para cadenas multibyte
12. **Fileinfo** - Para detección de tipos MIME
13. **BCMath** - Para cálculos matemáticos
14. **Tokenizer** - Para análisis de código PHP

### Configuración de php.ini Recomendada

```ini
# Configuraciones de Rendimiento
memory_limit = 512M
max_execution_time = 300
max_input_time = 300
upload_max_filesize = 64M
post_max_size = 64M
max_file_uploads = 20

# Configuraciones de Seguridad
display_errors = Off
log_errors = On
error_log = /path/to/your/website/storage/logs/php_errors.log
expose_php = Off

# Configuraciones de Sesión
session.save_handler = redis
session.save_path = "tcp://127.0.0.1:6379"
session.gc_maxlifetime = 7200
session.cookie_secure = On
session.cookie_httponly = On
session.use_strict_mode = 1

# Configuraciones de OPcache (Recomendado)
opcache.enable = 1
opcache.memory_consumption = 128
opcache.interned_strings_buffer = 8
opcache.max_accelerated_files = 4000
opcache.revalidate_freq = 2
opcache.fast_shutdown = 1

# Configuraciones de ionCube
zend_extension = /usr/lib/php/ioncube/ioncube_loader_lin_8.1.so
ioncube.loader.encoded_files = enabled
```

### Configuración de Nginx (si está disponible)

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name tu-dominio.com www.tu-dominio.com;
    root /path/to/your/website/public;
    index index.php index.html index.htm;

    # Configuración SSL (Let's Encrypt)
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/private.key;
    
    # Configuración SSL moderna
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256;
    ssl_prefer_server_ciphers off;

    # Redirección HTTP a HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name tu-dominio.com www.tu-dominio.com;
    root /path/to/your/website/public;
    index index.php index.html index.htm;

    # Configuraciones SSL
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/private.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256;
    ssl_prefer_server_ciphers off;

    # Headers de Seguridad
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

    # Configuración Laravel
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # PHP-FPM
    location ~ \.php$ {
        fastcgi_pass unix:/run/php/php8.1-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
        
        # Headers adicionales
        fastcgi_hide_header X-Powered-By;
    }

    # Cache estático
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
        add_header Vary Accept-Encoding;
    }

    # Proteger archivos sensibles
    location ~ /\. {
        deny all;
    }

    location ~ \.(env|ini|log|sh|sql|conf)$ {
        deny all;
    }

    # Logs
    access_log /path/to/your/website/storage/logs/nginx_access.log;
    error_log /path/to/your/website/storage/logs/nginx_error.log;
}
```

### Configuración de Cron Jobs

Agregar estos trabajos al crontab del sistema:

```bash
# Editar crontab
crontab -e

# Jobs necesarios para el Sistema CPS
# Procesar tareas en cola
* * * * * cd /path/to/your/website && php artisan queue:work --stop-when-empty >> /dev/null 2>&1

# Ejecutar programada de Laravel
* * * * * cd /path/to/your/website && php artisan schedule:run >> /dev/null 2>&1

# Limpiar logs antiguos (diario)
0 2 * * * find /path/to/your/website/storage/logs -name "*.log" -mtime +30 -delete

# Respaldar base de datos (si se requiere)
0 3 * * * /usr/bin/mysqldump -u tu_usuario -p'tu_password' cps_db > /backup/cps_db_$(date +\\%Y\\%m\\%d).sql

# Optimizar base de datos (semanal)
0 4 * * 0 /usr/bin/mysqlcheck -u tu_usuario -p'tu_password' --optimize --all-databases
```

### Configuración de Backup

#### Backup Automático Diario

Crear script `/backup/cps_backup.sh`:

```bash
#!/bin/bash

# Configuración
DB_NAME="cps_db"
DB_USER="tu_usuario"
DB_PASS="tu_password"
BACKUP_DIR="/backup/cps"
DATE=$(date +%Y%m%d_%H%M%S)

# Crear directorio de backup
mkdir -p $BACKUP_DIR

# Backup de base de datos
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/db_backup_$DATE.sql

# Backup de archivos de usuario
tar -czf $BACKUP_DIR/files_backup_$DATE.tar.gz /path/to/your/website/storage/app/public/

# Limpiar backups antiguos (mantener últimos 7 días)
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete

echo "Backup completado: $DATE"
```

Agregar al crontab:
```bash
0 3 * * * /backup/cps_backup.sh >> /var/log/cps_backup.log 2>&1
```

### Configuración de Monitoreo

#### Configuración de Alertas por Email

Para configurar alertas automáticas en caso de errores:

1. **Script de Verificación** (`/monitor/check_cps.sh`):
```bash
#!/bin/bash

# Verificar que el sitio responda
if ! curl -s https://tu-dominio.com/panel > /dev/null; then
    echo "ALERTA: El sistema CPS no responde" | mail -s "Sistema CPS Caído" admin@tu-dominio.com
fi

# Verificar logs de error
ERROR_COUNT=$(grep -i "fatal\|critical" /path/to/your/website/storage/logs/laravel.log | grep $(date +%Y-%m-%d) | wc -l)

if [ $ERROR_COUNT -gt 0 ]; then
    echo "ALERTA: $ERROR_COUNT errores críticos encontrados en el log" | mail -s "Errores en Sistema CPS" admin@tu-dominio.com
fi
```

2. **Ejecutar cada 5 minutos**:
```bash
*/5 * * * * /monitor/check_cps.sh
```

### Configuración de SSL con Let's Encrypt

```bash
# Instalar Certbot
sudo apt install certbot python3-certbot-nginx

# Obtener certificado SSL
sudo certbot --nginx -d tu-dominio.com -d www.tu-dominio.com

# Auto-renovación
sudo crontab -e
# Agregar: 0 12 * * * /usr/bin/certbot renew --quiet
```

### Variables de Entorno de Producción

Mantener las siguientes variables en `.env` para producción:

```env
# Seguridad
APP_DEBUG=false
LOG_LEVEL=notice
SESSION_SECURE_COOKIE=true
SESSION_HTTP_ONLY=true

# Performance
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis

# Monitoreo
LOG_CHANNEL=stack

# SSL
FORCE_HTTPS=true
```

---

**Esta configuración asegura un despliegue robusto y seguro del Sistema CPS en EasyPanel.**