# 🔧 Configuración de Dominio cps.qhosting.net

## 📋 Problema Identificado

La aplicación no se visualiza en `cps.qhosting.net` debido a conflictos de configuración entre:
- Puerto interno: 3000 (donde corre la app)
- Dominio externo: cps.qhosting.net (puerto 80/443)

## 🔧 Correcciones Aplicadas

### 1. Variables de Entorno Actualizadas

**En docker-compose.yml:**
```yaml
- APP_URL=https://cps.qhosting.net
- DB_HOST=mysql
- DB_DATABASE=cps_system
- DB_USERNAME=cps_user
- DB_PASSWORD=cps_secure_password_2025
- REDIS_HOST=qhosting_cps-redis
- REDIS_PASSWORD=cps-redis
```

### 2. Configuración de Nginx

**Agregado soporte para reverse proxy:**
```nginx
real_ip_header X-Forwarded-For;
real_ip_recursive on;
```

### 3. Health Checks Mejorados

**Endpoints disponibles:**
- `/health` - Health check básico
- `/api/health` - Health check de Laravel

## 🚀 Pasos para Resolver

### Paso 1: Actualizar EasyPanel

1. **En EasyPanel**: Ve a tu proyecto CPS
2. **Redeploy**: Ejecuta un nuevo build/deploy
3. **Verifica**: Que las nuevas variables se apliquen

### Paso 2: Configurar Dominio en EasyPanel

1. **Navega a**: Settings > Domains
2. **Agregar dominio**: `cps.qhosting.net`
3. **Tipo**: Point to internal service
4. **Puerto interno**: `3000`
5. **SSL**: Activa HTTPS si está disponible

### Paso 3: Verificar Configuración

1. **Accede a**: `https://cps.qhosting.net`
2. **Health check**: `https://cps.qhosting.net/health`
3. **API health**: `https://cps.qhosting.net/api/health`

### Paso 4: Verificar Base de Datos

1. **En EasyPanel**: Ve a la sección MySQL
2. **Verifica que existe**: Base de datos `cps_system`
3. **Credenciales correctas**: 
   - Usuario: `cps_user`
   - Password: `cps_secure_password_2025`

### Paso 5: Verificar Redis

1. **En EasyPanel**: Ve a la sección Redis
2. **Verifica**: Instancia `qhosting_cps-redis`
3. **Password**: `cps-redis`

## 🔍 Verificación de Logs

Si aún no funciona, revisa:

### Logs del Contenedor
```bash
# En EasyPanel o via SSH
docker logs cps-system
```

### Logs de Nginx
```bash
# Dentro del contenedor
docker exec -it cps-system cat /var/log/nginx/access.log
docker exec -it cps-system cat /var/log/nginx/error.log
```

### Logs de PHP-FPM
```bash
# Dentro del contenedor
docker exec -it cps-system cat /var/log/php-fpm.log
```

## 🚨 Problemas Comunes

### 1. Error 502/503 Bad Gateway
**Causa**: Nginx no puede conectar al puerto 3000
**Solución**: Verificar que el contenedor esté ejecutándose en puerto 3000

### 2. Error "Database connection failed"
**Causa**: Credenciales de BD incorrectas
**Solución**: Verificar variables DB_* en EasyPanel

### 3. Error "Redis connection failed"
**Causa**: Redis no disponible
**Solución**: Verificar instancia Redis en EasyPanel

### 4. Página en blanco
**Causa**: Laravel no puede cargar
**Solución**: Verificar logs de aplicación y permisos

## ✅ Configuración Exitosa

Cuando todo esté funcionando correctamente verás:

1. **cps.qhosting.net** carga la aplicación CPS
2. **Health check** devuelve "healthy"
3. **Logs limpios** sin errores críticos
4. **Base de datos** conectada correctamente

## 📞 Troubleshooting Adicional

### Si el dominio sigue sin funcionar:

1. **Verifica SSL**: Asegúrate de que el certificado SSL esté configurado
2. **DNS**: Confirma que cps.qhosting.net apunta a tu servidor EasyPanel
3. **Firewall**: Verifica que los puertos 80/443 estén abiertos
4. **Reverse Proxy**: EasyPanel debe configurar el reverse proxy automáticamente

### Comandos de diagnóstico:

```bash
# Verificar que el contenedor responde
curl -I http://localhost:3000/health

# Verificar configuración nginx
docker exec -it cps-system nginx -t

# Verificar logs en tiempo real
docker logs -f cps-system
```

---

**Nota**: Estas correcciones sincronizan la configuración con tus variables de entorno actuales y optimizan la compatibilidad con EasyPanel para el dominio cps.qhosting.net.