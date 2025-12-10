# CPS License Management System - Validation Scripts

Este directorio contiene scripts de validación completos para el sistema CPS (License Management) desplegado en Easypanel.

## 🎯 Objetivo

Los scripts de validación están diseñados para:
- **Detectar problemas post-deploy** automáticamente
- **Diagnosticar conectividad** en arquitectura Easypanel
- **Validar configuración** de Laravel, ionCube, base de datos
- **Monitorear continuamente** el estado del sistema
- **Generar logs** detallados para troubleshooting

## 🏗️ Arquitectura Easypanel

```
[Usuario] → [Dominio: https://cps.qhosting.net] 
         ↓
    [Proxy Reverso Easypanel] 
         ↓
    [Aplicación: Puerto 3000] ← [Validación Interna]
```

**Componentes validados:**
- ✅ Puerto 3000 (aplicación interna)
- ✅ Proxy reverso (acceso externo)
- ✅ Base de datos MariaDB
- ✅ Redis Cache
- ✅ ionCube Loader (requerido para CPS)
- ✅ Configuración Laravel
- ✅ Permisos de archivos

## 📋 Scripts Principales

### 🔍 Validación Completa
```bash
php validate_deployment_easypanel.php
```
- Validación exhaustiva de todos los componentes
- Genera reporte detallado con recomendaciones
- Tiempo de ejecución: ~2-3 minutos

### ⚡ Validación Rápida  
```bash
bash quick_validate_easypanel.sh
```
- Diagnóstico rápido de conectividad
- Ideal para troubleshooting inicial
- Tiempo de ejecución: ~30 segundos

### 🚀 Auto-Post-Deploy
```bash
bash post_deploy_validation.sh
```
- Ejecuta automáticamente después del deploy
- Genera logs detallados con timestamp
- Crea resumen en `logs/latest_status.txt`

### 📊 Monitoreo Continuo
```bash
bash monitor_cps_easypanel.sh --daemon --interval 30
```
- Monitoreo en tiempo real
- Detección automática de problemas
- Rotación automática de logs

## 🚀 Uso Post-Deploy

### 1. Integración Automática
```bash
# Ejecutar integración con deploy existente
bash integrate_validation.sh
```

Esto modifica automáticamente `deploy.sh` para incluir validación post-deploy.

### 2. Ejecución Manual
```bash
# Después de deploy o reinicio
cd /workspace/validation-scripts
bash post_deploy_validation.sh

# Ver resultados
cat logs/latest_status.txt
```

### 3. Monitoreo Continuo
```bash
# Iniciar monitoreo en background
bash monitor_cps_easypanel.sh --daemon --interval 60

# Ver logs en tiempo real
tail -f monitoring/monitor_*.log
```

## 📊 Interpretación de Resultados

### ✅ Estados Esperados
- **Puerto 3000**: LISTENING
- **HTTP Interno**: 200/301/302
- **HTTP Externo**: 200/301/302
- **Base de Datos**: CONNECTED
- **Redis**: CONNECTED
- **ionCube**: LOADED

### ❌ Problemas Comunes

| Síntoma | Causa Probable | Solución |
|---------|----------------|----------|
| Port 3000: NOT LISTENING | Aplicación no iniciada | `docker restart cps-app` |
| Internal HTTP: FAILED | Error en aplicación | Verificar logs de Laravel |
| External HTTP: FAILED | Problema proxy | Verificar configuración Easypanel |
| Database: CONNECTION FAILED | MariaDB no accesible | Verificar servicio y credenciales |
| ionCube: NOT LOADED | Extensión PHP faltante | Instalar ionCube Loader |

## 📁 Estructura de Logs

```
validation-scripts/
├── logs/                           # Logs de validación
│   ├── deploy_validation_*.log     # Logs detallados post-deploy
│   └── latest_status.txt          # Resumen del último estado
├── monitoring/                     # Logs de monitoreo
│   └── monitor_*.log              # Logs de monitoreo continuo
└── *.php, *.sh                    # Scripts de validación
```

## 🔧 Configuración Personalizada

### Variables Principales
```php
// En validate_deployment_easypanel.php
'app_url' => 'https://cps.qhosting.net',    // Tu dominio
'internal_url' => 'http://localhost:3000',  // URL interna
'internal_port' => 3000                     // Puerto interno
```

### Dominios y URLs
- **Externo**: `https://cps.qhosting.net`
- **Interno**: `http://localhost:3000`
- **Puerto Aplicación**: `3000`
- **Puerto Base de Datos**: `3306`
- **Puerto Redis**: `6379`

## 📋 Checklist Post-Deploy

- [ ] **Puerto 3000 listening**
- [ ] **HTTP interno responde** (200/301/302)
- [ ] **HTTP externo responde** (200/301/302)
- [ ] **Base de datos conectada**
- [ ] **Redis conectado**
- [ ] **ionCube Loader cargado**
- [ ] **Sin errores críticos en logs**
- [ ] **Monitoreo configurado**

## 🎯 Casos de Uso

### 1. Deploy Fallido
```bash
# Diagnosticar inmediatamente
cd validation-scripts
bash quick_validate_easypanel.sh

# Ver detalles
php validate_deployment_easypanel.php
```

### 2. Monitoreo Proactivo
```bash
# Configurar monitoreo continuo
bash monitor_cps_easypanel.sh --daemon --interval 60

# Ver estado actual
cat logs/latest_status.txt
```

### 3. Troubleshooting Específico
```bash
# Solo conectividad
bash quick_validate_easypanel.sh

# Validación completa
php validate_deployment_easypanel.php

# Ver logs detallados
ls logs/
cat logs/deploy_validation_*.log
```

## 📞 Soporte

### Logs Importantes
- `logs/latest_status.txt` - Estado actual del sistema
- `logs/deploy_validation_*.log` - Detalles de validación
- `monitoring/monitor_*.log` - Logs de monitoreo

### Comandos de Diagnóstico
```bash
# Estado de contenedores
docker ps

# Logs de aplicación
docker logs cps-app

# Estado de servicios
docker-compose ps

# Conectividad de red
netstat -tuln | grep 3000
curl -v http://localhost:3000
curl -v https://cps.qhosting.net
```

## 🔄 Actualizaciones

Para actualizar los scripts:
1. Hacer backup de logs actuales
2. Reemplazar scripts con nuevas versiones
3. Ejecutar validación para verificar funcionamiento
4. Revisar logs para confirmar operación normal

---

**Nota**: Estos scripts están optimizados específicamente para la arquitectura de Easypanel. Para entornos estándar (puertos 80/443), usar scripts sin "easypanel" en el nombre.

**Versión**: 1.0  
**Fecha**: 2025-12-10  
**Autor**: MiniMax Agent