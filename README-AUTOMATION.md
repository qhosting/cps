# CPS License Management - Automatización Completa

## 📋 Descripción

Este repositorio contiene un sistema completo de automatización para el despliegue, monitoreo y actualización del sistema CPS License Management.

## 🚀 Scripts de Automatización Disponibles

### 1. `deploy.sh` - Despliegue Automático Completo

**Propósito**: Instalación y configuración completa del sistema desde cero.

**Características**:
- Instalación automática de dependencias
- Configuración de firewall y seguridad
- Configuración SSL con Let's Encrypt
- Configuración de Nginx optimizada
- Sistema de monitoreo automático
- Backups automáticos
- Modo mantenimiento

**Uso**:
```bash
# Despliegue completo con parámetros personalizados
sudo ./deploy.sh cps.qhosting.net admin@qhosting.net cps_database username secure_password_123

# Solo instalación básica
sudo ./deploy.sh
```

**Parámetros**:
- `$1`: Dominio (por defecto: cps.qhosting.net)
- `$2`: Email para SSL (por defecto: admin@qhosting.net)
- `$3`: Nombre de base de datos (por defecto: cps_database)
- `$4`: Usuario de base de datos (por defecto: username)
- `$5`: Contraseña de base de datos (por defecto: secure_password_123)

### 2. `monitor.sh` - Monitoreo Continuo

**Propósito**: Monitoreo continuo del sistema con alertas automáticas.

**Características**:
- Verificación de servicios (Nginx, PHP-FPM, MySQL)
- Monitoreo de recursos (disco, memoria, CPU)
- Verificación de logs de errores
- Pruebas de conectividad web
- Verificación de certificados SSL
- Sistema de alertas configurables
- Reportes automáticos diarios

**Uso**:
```bash
# Monitoreo continuo (cada 5 minutos)
sudo ./monitor.sh daemon 300

# Verificación única de salud
sudo ./monitor.sh health

# Ver estado actual
sudo ./monitor.sh status

# Prueba de rendimiento
sudo ./monitor.sh test

# Generar reporte diario
sudo ./monitor.sh report
```

### 3. `update.sh` - Actualización Automática

**Propósito**: Actualización automática del sistema con backup y rollback.

**Características**:
- Backup automático antes de actualizar
- Verificación de actualizaciones disponibles
- Actualización de dependencias
- Ejecución de migraciones
- Optimización para producción
- Rollback automático en caso de error
- Programación de actualizaciones

**Uso**:
```bash
# Actualización automática completa
sudo ./update.sh auto

# Verificar actualizaciones disponibles
sudo ./update.sh check

# Forzar actualización
sudo ./update.sh force

# Restaurar desde backup
sudo ./update.sh rollback /opt/backups/cps/full_20241209_103000.tar.gz

# Programar actualizaciones (domingos a las 2 AM)
sudo ./update.sh schedule "0 2 * * 0"

# Mostrar información del repositorio
sudo ./update.sh status

# Limpiar backups antiguos
sudo ./update.sh cleanup
```

## 🔧 Configuración y Requisitos

### Requisitos del Sistema

- **Sistema Operativo**: Ubuntu 20.04+ / Debian 11+
- **RAM**: Mínimo 2GB, recomendado 4GB+
- **Disco**: Mínimo 10GB de espacio libre
- **Privilegios**: Acceso root para instalación
- **Docker**: Se instala automáticamente
- **Git**: Para clonar el repositorio

### Variables de Entorno

El sistema utiliza las siguientes variables de entorno que se configuran automáticamente:

```env
APP_NAME="CPS License Management"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://cps.qhosting.net

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=cps_database
DB_USERNAME=username
DB_PASSWORD=password

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null

STRIPE_KEY=your_stripe_public_key
STRIPE_SECRET=your_stripe_secret_key
PAYPAL_CLIENT_ID=your_paypal_client_id
PAYPAL_CLIENT_SECRET=your_paypal_client_secret
PAYPAL_MODE=sandbox
```

## 🛠️ Instalación Rápida

### Instalación Automática Completa

```bash
# 1. Clonar repositorio
git clone https://github.com/qhosting/cps.git
cd cps

# 2. Hacer ejecutables los scripts
chmod +x *.sh

# 3. Ejecutar despliegue completo
sudo ./deploy.sh cps.qhosting.net admin@qhosting.net cps_database username secure_password_123

# 4. Configurar monitoreo
sudo ./monitor.sh daemon 300 &

# 5. Verificar estado
sudo ./monitor.sh status
```

### Instalación Paso a Paso

```bash
# 1. Clonar repositorio
git clone https://github.com/qhosting/cps.git
cd cps

# 2. Hacer ejecutables los scripts
chmod +x *.sh

# 3. Ejecutar cada script individualmente
sudo ./setup.sh          # Configuración inicial
sudo ./deploy.sh         # Despliegue
sudo ./monitor.sh daemon # Monitoreo
sudo ./update.sh auto    # Primera actualización
```

## 📊 Monitoreo y Logs

### Archivos de Log

- **Logs del Sistema**: `/var/log/cps-deploy.log`
- **Logs de Monitoreo**: `/var/log/cps-monitor.log`
- **Logs de Actualización**: `/var/log/cps-update.log`
- **Logs de Laravel**: `/var/www/system/storage/logs/laravel.log`
- **Logs de Nginx**: `/var/log/nginx/error.log`
- **Logs del Sistema**: `/var/log/syslog`

### Comandos de Diagnóstico

```bash
# Ver estado de servicios
sudo systemctl status nginx
sudo systemctl status php8.3-fpm
sudo systemctl status mysql

# Ver logs en tiempo real
sudo tail -f /var/log/cps-monitor.log
sudo tail -f /var/www/system/storage/logs/laravel.log

# Verificar recursos
df -h
free -h
top

# Verificar conectividad
curl -I https://cps.qhosting.net
```

## 🔄 Actualizaciones y Mantenimiento

### Actualizaciones Automáticas

```bash
# Configurar actualizaciones automáticas
sudo ./update.sh schedule "0 2 * * 0"  # Domingos a las 2 AM

# Ver actualizaciones pendientes
sudo ./update.sh check

# Ejecutar actualización manual
sudo ./update.sh auto
```

### Modo Mantenimiento

```bash
# Habilitar modo mantenimiento
sudo /usr/local/bin/cps-maintenance.sh enable

# Deshabilitar modo mantenimiento
sudo /usr/local/bin/cps-maintenance.sh disable
```

### Backups

```bash
# Los backups se crean automáticamente en:
/opt/backups/cps/

# Ejecutar backup manual
sudo /usr/local/bin/cps-backup.sh

# Restaurar desde backup
sudo ./update.sh rollback /opt/backups/cps/full_20241209_103000.tar.gz
```

## 🚨 Alertas y Notificaciones

### Configuración de Alertas

Los scripts incluyen sistema de alertas que puede configurarse para:

- **Email**: Usando mailutils o servicios SMTP
- **Slack**: Webhooks de Slack
- **Telegram**: Bots de Telegram
- **Discord**: Webhooks de Discord
- **PagerDuty**: Servicios de monitoreo empresarial

### Umbrales de Alerta

- **Disco**: 90% de uso
- **Memoria**: 80% de uso
- **CPU**: 80% de uso
- **Errores Laravel**: 10 errores en 100 líneas de log
- **Tiempo de respuesta**: > 5 segundos
- **Certificado SSL**: < 30 días para expirar

## 🔒 Seguridad

### Medidas de Seguridad Implementadas

1. **Firewall**: UFW configurado automáticamente
2. **Fail2Ban**: Protección contra ataques de fuerza bruta
3. **SSL/TLS**: Certificados Let's Encrypt automáticos
4. **Headers de Seguridad**: CSP, X-Frame-Options, etc.
5. **Permisos de Archivos**: Configuración segura automática
6. **Actualizaciones**: Sistema de updates con rollback

### Hardening Adicional

```bash
# Configurar SSH (recomendado)
sudo nano /etc/ssh/sshd_config
# Cambiar puerto por defecto y deshabilitar root login

# Instalar herramientas adicionales de seguridad
sudo apt install rkhunter chkrootkit aide
```

## 🆘 Solución de Problemas

### Problemas Comunes

#### Error: "Please provide a valid cache path"
- **Solución**: El Dockerfile ha sido corregido para crear www-data antes de composer install
- **Verificar**: `ls -la /var/www/bootstrap/cache`

#### Servicios no inician
```bash
# Reiniciar servicios
sudo systemctl restart nginx
sudo systemctl restart php8.3-fpm

# Verificar logs
sudo journalctl -u nginx -f
sudo journalctl -u php8.3-fpm -f
```

#### Problemas de permisos
```bash
# Reparar permisos
sudo chown -R www-data:www-data /var/www
sudo chmod -R 755 /var/www
sudo chmod -R 777 /var/www/bootstrap/cache
sudo chmod -R 777 /var/www/storage
```

#### Error de base de datos
```bash
# Verificar conexión
sudo mysql -u username -p cps_database

# Verificar estado MySQL
sudo systemctl status mysql
```

### Rollback de Emergencia

```bash
# Si algo falla después de una actualización
sudo ./update.sh rollback /opt/backups/cps/full_20241209_103000.tar.gz

# Verificar estado después del rollback
sudo ./monitor.sh health
```

## 📈 Optimización de Rendimiento

### Optimizaciones Incluidas

1. **Composer**: Autoloader optimizado
2. **Laravel**: Caches de configuración, rutas y vistas
3. **Nginx**: Gzip compression y headers de cache
4. **PHP-FPM**: Configuración optimizada
5. **MySQL**: Configuración para producción

### Monitoreo de Rendimiento

```bash
# Ver uso de recursos
htop
iotop
nethogs

# Ver rendimiento de la aplicación
sudo ./monitor.sh test

# Ver logs de rendimiento
tail -f /var/log/nginx/access.log
```

## 📞 Soporte

### Información de Contacto

- **Repositorio**: https://github.com/qhosting/cps
- **Issues**: Reportar problemas en GitHub Issues
- **Documentación**: Este archivo y TROUBLESHOOTING.md

### Logs para Soporte

Cuando reportes un problema, incluye:

```bash
# Generar reporte de diagnóstico
sudo ./monitor.sh status > diagnostic-report.txt
sudo ./update.sh status >> diagnostic-report.txt
sudo journalctl --since "1 hour ago" >> diagnostic-report.txt
```

## 📝 Changelog

### Versión 1.0.0 (2024-12-09)

#### ✨ Nuevas Características
- Sistema de despliegue automático completo
- Monitoreo continuo con alertas
- Actualizaciones automáticas con backup
- Configuración de seguridad automática
- Sistema de backup automatizado
- Modo mantenimiento automático
- Reportes automáticos diarios

#### 🐛 Correcciones
- **FIX**: Error "Please provide a valid cache path" resuelto
- **FIX**: Orden correcto de creación de directorios en Dockerfile
- **FIX**: Usuario www-data creado antes de composer install
- **FIX**: Permisos correctos para directorios de cache

#### 🔧 Mejoras
- **IMPROVE**: Dockerfile optimizado con ionCube 15.0.0
- **IMPROVE**: Scripts de automatización robustos
- **IMPROVE**: Sistema de logging completo
- **IMPROVE**: Configuración de Nginx optimizada
- **IMPROVE**: Manejo de errores mejorado

#### 🛡️ Seguridad
- **SECURITY**: Firewall automático configurado
- **SECURITY**: Fail2Ban para protección SSH
- **SECURITY**: Headers de seguridad en Nginx
- **SECURITY**: SSL/TLS automático con Let's Encrypt

---

## 📚 Documentación Adicional

- [README.md](README.md) - Documentación principal
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Solución de problemas
- [docker-compose.yml](docker-compose.yml) - Configuración Docker
- [init.sh](init.sh) - Inicialización del sistema
- [maintenance.sh](maintenance.sh) - Scripts de mantenimiento

---

**Desarrollado por MiniMax Agent** | **Versión 1.0.0** | **2024-12-09**