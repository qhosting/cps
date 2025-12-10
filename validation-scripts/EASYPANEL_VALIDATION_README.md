# CPS Validation Scripts for Easypanel

Este conjunto de scripts está específicamente diseñado para validar el sistema CPS (License Management) desplegado en Easypanel. Los scripts detectan automáticamente la arquitectura de Easypanel donde las aplicaciones usan puerto 3000 internamente con proxy reverso al dominio.

## 🏗️ Arquitectura Easypanel

En Easypanel:
- **Puerto 3000**: Puerto interno donde la aplicación Laravel escucha
- **Proxy Reverso**: Easypanel maneja el acceso externo vía dominio
- **Dominio**: `https://cps.qhosting.net` (externo)
- **URL Interna**: `http://localhost:3000` (interno)

## 📋 Scripts Disponibles

### 1. Validación Completa (`validate_deployment_easypanel.php`)
Validación exhaustiva del sistema CPS en entorno Easypanel.

**Uso:**
```bash
php validate_deployment_easypanel.php
```

**Verifica:**
- ✅ Conectividad interna (puerto 3000)
- ✅ Conectividad externa (proxy reverso)
- ✅ Conexión a base de datos MariaDB
- ✅ Conexión a Redis
- ✅ Configuración Laravel (.env, permisos)
- ✅ ionCube Loader (requerido para código encriptado CPS)
- ✅ Archivos de logs
- ✅ Servicios del sistema

### 2. Validación Rápida (`quick_validate_easypanel.sh`)
Diagnóstico rápido para problemas de conectividad.

**Uso:**
```bash
bash quick_validate_easypanel.sh
```

**Tiempo de ejecución:** ~30 segundos
**Ideal para:** Verificación inicial y troubleshooting

### 3. Auto-Validación Post-Deploy (`post_deploy_validation.sh`)
Script para ejecutar automáticamente después del deploy.

**Uso manual:**
```bash
bash post_deploy_validation.sh
```

**Características:**
- Genera logs detallados con timestamp
- Se ejecuta automáticamente en post-deploy
- Crea resumen de estado en `logs/latest_status.txt`

### 4. Monitoreo Continuo (`monitor_cps_easypanel.sh`)
Monitoreo en tiempo real del sistema CPS.

**Uso como daemon:**
```bash
bash monitor_cps_easypanel.sh --daemon --interval 30
```

**Uso único:**
```bash
bash monitor_cps_easypanel.sh --once
```

**Modos disponibles:**
- `--once`: Ejecuta una verificación y termina
- `--daemon`: Ejecuta continuamente
- `--type quick`: Solo verificaciones básicas
- `--type full`: Verificación completa (por defecto)

## 🚀 Integración con Deploy

### Para Auto-Ejecución Post-Deploy

1. **Agregar al script de deploy:**
```bash
# Al final del deploy.sh, agregar:
cd /workspace/validation-scripts
bash post_deploy_validation.sh
```

2. **Ver resultados:**
```bash
# Ver log más reciente
cat validation-scripts/logs/latest_status.txt

# Ver logs detallados
ls validation-scripts/logs/
```

### Para Monitoreo Continuo

1. **Iniciar monitoreo en background:**
```bash
bash monitor_cps_easypanel.sh --daemon --interval 60
```

2. **Ver logs de monitoreo:**
```bash
tail -f validation-scripts/monitoring/monitor_*.log
```

## 📊 Interpretación de Resultados

### Estados de Conectividad

| Componente | Estado | Significado |
|------------|--------|-------------|
| **Puerto 3000** | LISTENING | ✅ Aplicación ejecutándose correctamente |
| **Puerto 3000** | NOT LISTENING | ❌ Aplicación no iniciada o error de configuración |
| **HTTP Interno** | 200/301/302 | ✅ Aplicación respondiendo internamente |
| **HTTP Externo** | 200/301/302 | ✅ Proxy reverso funcionando |
| **HTTP Externo** | 404/500 | ⚠️ Error en aplicación o proxy |

### Problemas Comunes y Soluciones

#### 1. Puerto 3000 No Listening
**Síntomas:**
- `✗ Port 3000: NOT LISTENING`
- `✗ Internal HTTP: FAILED`

**Soluciones:**
```bash
# Verificar estado del contenedor
docker ps

# Verificar logs de la aplicación
docker logs cps-app

# Reiniciar aplicación
docker restart cps-app
```

#### 2. Error de Base de Datos
**Síntomas:**
- `✗ Database: CONNECTION FAILED`

**Soluciones:**
```bash
# Verificar MariaDB
docker exec -it cps-mariadb mysql -u root -p

# Verificar configuración .env
grep DB_ /workspace/system/.env

# Reiniciar MariaDB
docker restart cps-mariadb
```

#### 3. ionCube Loader No Cargado
**Síntomas:**
- `✗ ionCube Loader: NOT LOADED`

**Soluciones:**
```bash
# Verificar PHP
docker exec -it cps-php php -m | grep ionCube

# Verificar configuración PHP
docker exec -it cps-php php --ini

# Reiniciar contenedor PHP
docker restart cps-php
```

#### 4. Problemas de Proxy Reverso
**Síntomas:**
- `✗ External HTTP: FAILED` (pero interno funciona)

**Soluciones:**
- Verificar configuración de dominio en Easypanel
- Verificar certificados SSL
- Comprobar reglas de proxy reverso

## 📁 Estructura de Logs

```
validation-scripts/
├── logs/
│   ├── deploy_validation_2025-12-10_09-00-00.log
│   └── latest_status.txt
└── monitoring/
    └── monitor_2025-12-10_09-00-00.log
```

### Archivos de Log Importantes

- **`latest_status.txt`**: Resumen del último estado
- **`deploy_validation_*.log`**: Log detallado de validación post-deploy
- **`monitor_*.log`**: Logs de monitoreo continuo

## 🔧 Configuración Personalizada

### Variables de Configuración

En cada script puedes modificar:

```php
// En validate_deployment_easypanel.php
private $config = [
    'app_url' => 'https://cps.qhosting.net',        // Tu dominio
    'internal_url' => 'http://localhost:3000',      // URL interna
    'internal_port' => 3000,                        // Puerto interno
    'database' => [
        'host' => '127.0.0.1',
        'port' => 3306,
        'database' => 'cps_database'
    ]
];
```

```bash
# En scripts .sh
APP_URL="https://cps.qhosting.net"        # Tu dominio
INTERNAL_URL="http://localhost:3000"      # URL interna
INTERVAL=30                               # Intervalo de monitoreo
```

## 📞 Troubleshooting

### Problema: Scripts No Ejecutables
```bash
# No necesitas permisos de ejecución
php validate_deployment_easypanel.php
bash quick_validate_easypanel.sh
```

### Problema: Errores de Conexión
```bash
# Verificar conectividad de red
curl -v http://localhost:3000
curl -v https://cps.qhosting.net

# Verificar puertos
netstat -tuln | grep 3000
ss -tuln | grep 3000
```

### Problema: Base de Datos No Accesible
```bash
# Verificar MariaDB
docker exec -it cps-mariadb mysql -u root -p -e "SHOW DATABASES;"

# Verificar configuración
cat /workspace/system/.env | grep DB_
```

## 📋 Checklist Post-Deploy

- [ ] Ejecutar `quick_validate_easypanel.sh`
- [ ] Verificar puerto 3000 listening
- [ ] Verificar conectividad interna
- [ ] Verificar conectividad externa
- [ ] Verificar base de datos
- [ ] Verificar ionCube Loader
- [ ] Verificar logs sin errores
- [ ] Configurar monitoreo continuo

## 🎯 Comandos Útiles

```bash
# Validación rápida
bash quick_validate_easypanel.sh

# Validación completa
php validate_deployment_easypanel.php

# Post-deploy automático
bash post_deploy_validation.sh

# Monitoreo continuo (cada 30s)
bash monitor_cps_easypanel.sh --daemon

# Ver estado actual
cat validation-scripts/logs/latest_status.txt

# Ver logs en tiempo real
tail -f validation-scripts/monitoring/monitor_*.log
```

---

**Nota:** Estos scripts están optimizados para la arquitectura de Easypanel. Para entornos estándar (puertos 80/443), usar los scripts sin "easypanel" en el nombre.