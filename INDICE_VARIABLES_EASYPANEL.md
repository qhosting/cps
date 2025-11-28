# 📋 Índice Completo: Variables de Entorno para EasyPanel

## 🎯 Resumen de lo que hemos creado

He creado una **guía completa** para configurar las variables de entorno de EasyPanel para tu sistema CPS. Aquí tienes todo lo que necesitas:

## 📁 Archivos Creados

### 📖 Documentación Principal

| Archivo | Descripción | Uso |
|---------|-------------|-----|
| **`GUIA_VARIABLES_ENV_EASYPANEL.md`** | Guía completa teórica | Lectura para entender conceptos |
| **`CONFIGURAR_EASYPANEL_PASO_A_PASO.md`** | Instrucciones paso a paso | **Sigue esta guía para configurar** |
| **`INDICE_VARIABLES_EASYPANEL.md`** | Este archivo índice | Navegación rápida |

### 🔧 Herramientas y Scripts

| Archivo | Descripción | Uso |
|---------|-------------|-----|
| **`generate-easypanel-env.sh`** | Generador automático de .env | `bash generate-easypanel-env.sh` |
| **`comandos-debug-easypanel.sh`** | Scripts de verificación y debug | `bash comandos-debug-easypanel.sh` |
| **`Dockerfile.easypanel`** | Dockerfile optimizado para EasyPanel | Reemplaza tu Dockerfile actual |

## 🚀 Guía Rápida de Configuración

### Paso 1: Configurar Variables en EasyPanel
Sigue esta guía: **`CONFIGURAR_EASYPANEL_PASO_A_PASO.md`**

### Paso 2: Configurar Variables Manuales
En tu panel EasyPanel → Proyecto CPS → Configuración → Variables de Entorno, agrega:

```bash
APP_NAME = CPS
APP_ENV = production
APP_DEBUG = false
APP_LICENSE = license_tu_clave_de_licencia
API_TOKEN = tu_token_api_aqui
MAIL_HOST = smtp.tu-proveedor-email.com
MAIL_USERNAME = tu-email@dominio.com
MAIL_PASSWORD = tu_password_email
```

### Paso 3: Verificar Configuración
```bash
bash comandos-debug-easypanel.sh
```

## 🔍 Variables que EasyPanel Configura Automáticamente

Estas variables NO las configures manualmente:

```bash
EASYPANEL = true                     # Auto
EASYPANEL_PROJECT = cps_qhosting     # Auto
EASYPANEL_DOMAIN = tu-dominio.com    # Auto
HOST = 0.0.0.0                       # Auto
PORT = 80                            # Auto
DB_HOST = mysql                      # Auto
DB_DATABASE = cps_database           # Auto
DB_USERNAME = cps_user               # Auto
DB_PASSWORD = cps_password_123       # Auto
REDIS_HOST = redis                   # Auto
REDIS_PORT = 6379                    # Auto
```

## 🎯 Próximos Pasos Inmediatos

### 1. **Configurar Variables Manual** (5 minutos)
1. Ve a EasyPanel → Proyecto CPS → Configuración
2. Busca "Variables de Entorno"
3. Agrega las variables listadas arriba

### 2. **Verificar Variables Automáticas** (2 minutos)
Ejecuta en tu contenedor:
```bash
printenv | grep EASYPANEL
```

### 3. **Probar Conectividad** (3 minutos)
```bash
# MySQL
mysql -h$DB_HOST -P$DB_PORT -u$DB_USERNAME -p$DB_PASSWORD -e "SELECT 1;"

# Redis  
redis-cli -h$REDIS_HOST -p$REDIS_PORT ping
```

### 4. **Verificar Aplicación** (1 minuto)
Abre tu navegador y ve a tu dominio para verificar que todo funciona.

## 🛠️ Scripts de Utilidad

### Generador Automático de .env
```bash
bash generate-easypanel-env.sh
```
**Qué hace**: Genera automáticamente un archivo .env optimizado combinando variables automáticas de EasyPanel con configuraciones específicas de CPS.

### Script de Debug Completo
```bash
bash comandos-debug-easypanel.sh
```
**Qué hace**: Verifica variables, conectividad, PHP, Laravel, MySQL, Redis y genera reportes.

## 📊 Variables por Categoría

### 🔐 Configuración de Seguridad
```bash
APP_DEBUG = false                    # En producción
SESSION_SECURE_COOKIE = true         # Para HTTPS
SESSION_HTTP_ONLY = true             # Seguridad de cookies
SESSION_USE_STRICT_MODE = 1          # Modo estricto
```

### 🚀 Configuración de Performance
```bash
CACHE_DRIVER = redis                 # Cache rápido
SESSION_DRIVER = redis               # Sesiones en Redis
QUEUE_CONNECTION = redis             # Colas en Redis
OPACACHE_ENABLE = 1                  # Cache de código PHP
```

### 🗄️ Configuración de Base de Datos
```bash
DB_CONNECTION = mysql                # Motor de base de datos
DB_HOST = mysql                      # Host interno
DB_DATABASE = cps_database           # Nombre de base de datos
DB_USERNAME = cps_user               # Usuario
DB_PASSWORD = cps_password_123       # Contraseña
```

### 📧 Configuración de Email
```bash
MAIL_DRIVER = smtp                   # Protocolo SMTP
MAIL_HOST = smtp.tu-proveedor-email.com
MAIL_PORT = 587                      # Puerto SMTP
MAIL_USERNAME = tu-email@dominio.com
MAIL_PASSWORD = tu_password_email
MAIL_ENCRYPTION = tls                # Encriptación
MAIL_FROM_ADDRESS = noreply@tu-dominio.com
```

## 🆘 Solución de Problemas Comunes

### Error: "Variables no se cargan"
**Solución**: 
1. Reinicia el contenedor en EasyPanel
2. Verifica que las variables están guardadas
3. Ejecuta: `bash comandos-debug-easypanel.sh vars`

### Error: "MySQL no conecta"
**Solución**:
1. Verifica `DB_HOST=mysql` en variables
2. Ejecuta: `bash comandos-debug-easypanel.sh mysql`
3. Revisa que MySQL esté corriendo

### Error: "Redis no funciona"
**Solución**:
1. Verifica `REDIS_HOST=redis` en variables
2. Ejecuta: `bash comandos-debug-easypanel.sh redis`
3. Revisa logs de Redis

### Error: "ionCube no funciona"
**Solución**:
1. Verifica que ionCube esté en php.ini
2. Ejecuta: `bash comandos-debug-easypanel.sh php`
3. Verifica la licencia de ionCube

## 📋 Checklist de Configuración

Antes de considerar completado, verifica:

- [ ] ✅ Variables manuales configuradas en EasyPanel
- [ ] ✅ APP_KEY generada correctamente
- [ ] ✅ Base de datos MySQL conecta
- [ ] ✅ Redis conecta y funciona
- [ ] ✅ ionCube Loader funcionando
- [ ] ✅ Email SMTP configurado y probado
- [ ] ✅ Variables automáticas de EasyPanel disponibles
- [ ] ✅ Aplicación carga sin errores
- [ ] ✅ Logs no muestran errores críticos
- [ ] ✅ SSL/HTTPS funciona (si está habilitado)

## 🎉 ¡Configuración Completa!

Con estas herramientas y guías, tu sistema CPS estará **completamente optimizado para EasyPanel** con:

- ✅ **Variables automáticas** de EasyPanel funcionando
- ✅ **Configuración manual** específica de CPS
- ✅ **Debugging completo** para resolver problemas
- ✅ **Monitoreo en tiempo real** del estado del sistema
- ✅ **Optimización de performance** para producción

## 📞 Si Necesitas Ayuda

Si encuentras problemas:

1. **Ejecuta el script de debug**: `bash comandos-debug-easypanel.sh`
2. **Revisa los logs**: `tail -f storage/logs/laravel.log`
3. **Consulta las guías**: Lee los archivos de documentación
4. **Comparte el reporte**: El script genera un archivo con toda la información

---

**🎯 Siguiente paso recomendado**: Lee `CONFIGURAR_EASYPANEL_PASO_A_PASO.md` y configura las variables en tu panel EasyPanel.