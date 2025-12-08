# Troubleshooting Guide - Sistema CPS Docker

## Problemas Comunes y Soluciones

### 1. Error: "ionCube Loader not found"

**Síntomas:**
```
Warning: Failed loading Zend extension 'ioncube_loader_lin_8.3.so'
Script error: the ionCube Loader for PHP needs to be installed.
```

**Solución:**
1. Verifica que el archivo esté en la ubicación correcta:
   ```bash
   docker-compose exec app ls -la /usr/local/lib/php/extensions/no-debug-non-zts-20230831/
   ```

2. Si no existe, reconstruye la imagen:
   ```bash
   docker-compose down
   docker-compose up -d --build
   ```

### 2. Error de Composer: "Package not found"

**Síntomas:**
```
Composer could not find a composer.json file
```

**Solución:**
1. Verifica que los archivos estén copiados correctamente:
   ```bash
   docker-compose exec app ls -la /var/www/
   ```

2. Si falta el directorio system, asegúrate de que esté en el directorio raíz del proyecto.

### 3. Error de conexión MySQL

**Síntomas:**
```
SQLSTATE[HY000] [2002] Connection refused
```

**Solución:**
1. Verifica que MySQL esté ejecutándose:
   ```bash
   docker-compose ps
   docker-compose logs mysql
   ```

2. Espera a que MySQL esté completamente inicializado (puede tomar 1-2 minutos).

3. Verifica las credenciales en el archivo .env.

### 4. Error de permisos en Laravel

**Síntomas:**
```
Permission denied at storage/logs/laravel.log
```

**Solución:**
```bash
docker-compose exec app chown -R www-data:www-data /var/www/storage
docker-compose exec app chmod -R 775 /var/www/storage
```

### 5. Error: "Nginx 502 Bad Gateway"

**Síntomas:**
- Página muestra error 502 Bad Gateway

**Solución:**
1. Verifica que el servicio app esté funcionando:
   ```bash
   docker-compose exec app php -v
   ```

2. Verifica que nginx esté configurado correctamente:
   ```bash
   docker-compose exec web nginx -t
   ```

3. Reinicia los servicios:
   ```bash
   docker-compose restart
   ```

### 6. Problemas de rendimiento

**Síntomas:**
- Aplicación lenta o timeouts

**Solución:**
1. Verifica el uso de recursos:
   ```bash
   docker stats
   ```

2. Aumenta los límites de memoria en docker-compose.yml si es necesario.

## Comandos Útiles

### Verificar estado de todos los servicios
```bash
docker-compose ps
```

### Ver logs de un servicio específico
```bash
docker-compose logs app
docker-compose logs web
docker-compose logs mysql
docker-compose logs redis
```

### Ejecutar comandos dentro del contenedor
```bash
docker-compose exec app bash
docker-compose exec app php artisan --version
docker-compose exec mysql mysql -u root -p
```

### Reiniciar servicios
```bash
docker-compose restart
```

### Parar todos los servicios
```bash
docker-compose down
```

### Parar y eliminar volúmenes (CUIDADO: borra datos)
```bash
docker-compose down -v
```

## Monitoreo

### Ver uso de recursos
```bash
docker stats
```

### Verificar espacio en disco
```bash
docker system df
docker system prune
```

### Verificar conectividad de red
```bash
docker-compose exec web ping app
docker-compose exec app ping mysql
```

## Configuración de .env

Asegúrate de que tu archivo .env contenga:

```env
# Base de datos
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=cps_db
DB_USERNAME=cps_user
DB_PASSWORD=tu_password_seguro

# Redis
REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379

# Aplicación
APP_URL=http://tu-dominio.com
APP_KEY=base64:tu-clave-generada
```

## Verificación Final

Para verificar que todo está funcionando:

1. **Aplicación web**: http://tu-servidor
2. **PHPMyAdmin**: http://tu-servidor:8080
3. **Logs sin errores**: `docker-compose logs --tail=50`

Si todo funciona correctamente, deberías ver:
- Aplicación cargando sin errores ionCube
- Base de datos conectada
- Almacenamiento funcionando
- PHPMyAdmin accesible