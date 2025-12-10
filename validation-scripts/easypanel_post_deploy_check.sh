#!/bin/bash

################################################################################
# CPS Post-Deploy Diagnostic Script for Easypanel Console Logs
# Version: 1.0
# Author: MiniMax Agent
# Purpose: Automatic diagnostic after restart/deploy with console output
################################################################################

set -e

# Configuration
SCRIPT_DIR="/workspace/validation-scripts"
LOG_DIR="$SCRIPT_DIR/logs"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="$LOG_DIR/easypanel_check_$TIMESTAMP.log"
STATUS_FILE="$LOG_DIR/latest_status.txt"

# Create logs directory if not exists
mkdir -p "$LOG_DIR"

# Function to log to both console and file
log_output() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_message="[$timestamp] $message"
    echo "$log_message" | tee -a "$LOG_FILE"
}

# Function to log section headers
log_section() {
    local title="$1"
    local border="================================================================================"
    log_output ""
    log_output "$border"
    log_output " $title"
    log_output "$border"
}

# Start diagnostic
log_section "CPS POST-DEPLOY DIAGNOSTIC - Easypanel Console"

log_output "Script iniciado automáticamente después del deploy/reinicio"
log_output "Timestamp: $(date)"
log_output "Log file: $LOG_FILE"

# Quick System Status Check
log_section "1. VERIFICACIÓN RÁPIDA DEL SISTEMA"

# Check if port 3000 is listening
if netstat -tlnp 2>/dev/null | grep -q ":3000 "; then
    log_output "✅ Puerto 3000: ESCUCHANDO (CPS aplicación)"
else
    log_output "❌ Puerto 3000: NO ESCUCHA - PROBLEMA CRÍTICO"
fi

# Check PHP-FPM status
if pgrep -f "php-fpm" >/dev/null; then
    log_output "✅ PHP-FPM: CORRIENDO"
    PHP_PIDS=$(pgrep -f php-fpm | wc -l)
    log_output "   Procesos PHP-FPM activos: $PHP_PIDS"
else
    log_output "❌ PHP-FPM: NO CORRE"
fi

# Check if application responds on localhost:3000
log_section "2. PRUEBA DE CONECTIVIDAD INTERNA"

if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 >/tmp/curl_test.txt 2>/dev/null; then
    HTTP_CODE=$(cat /tmp/curl_test.txt)
    if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "302" ] || [ "$HTTP_CODE" = "301" ]; then
        log_output "✅ Conectividad localhost:3000: HTTP $HTTP_CODE (OK)"
    else
        log_output "⚠️ Conectividad localhost:3000: HTTP $HTTP_CODE (PROBLEMA)"
    fi
else
    log_output "❌ Conectividad localhost:3000: FALLO DE CONEXIÓN"
fi

# Database connectivity test
log_section "3. CONECTIVIDAD DE BASE DE DATOS"

if command -v mysql >/dev/null 2>&1; then
    if mysql -u cps_user -pcps_password123 -e "USE cps_database; SELECT 1;" >/dev/null 2>&1; then
        log_output "✅ Base de datos MariaDB: CONECTADA"
        # Get database size
        DB_SIZE=$(mysql -u cps_user -pcps_password123 -e "SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024, 1) AS 'DB Size in MB' FROM information_schema.tables WHERE table_schema='cps_database';" -s 2>/dev/null | tail -1)
        if [ ! -z "$DB_SIZE" ] && [ "$DB_SIZE" != "NULL" ]; then
            log_output "   Tamaño de base de datos: $DB_SIZE MB"
        fi
    else
        log_output "❌ Base de datos MariaDB: CONEXIÓN FALLIDA"
    fi
else
    log_output "⚠️ Comando mysql no disponible"
fi

# Redis connectivity test
log_section "4. CONECTIVIDAD DE CACHE (Redis)"

if command -v redis-cli >/dev/null 2>&1; then
    if redis-cli -h localhost -p 6379 ping >/dev/null 2>&1; then
        log_output "✅ Redis: CONECTADO"
        REDIS_INFO=$(redis-cli -h localhost -p 6379 info memory 2>/dev/null | grep used_memory_human | cut -d: -f2 | tr -d '\r')
        if [ ! -z "$REDIS_INFO" ]; then
            log_output "   Memoria Redis en uso: $REDIS_INFO"
        fi
    else
        log_output "❌ Redis: CONEXIÓN FALLIDA"
    fi
else
    log_output "⚠️ Comando redis-cli no disponible"
fi

# Laravel application checks
log_section "5. VERIFICACIÓN DE APLICACIÓN LARAVEL"

# Check .env file
if [ -f "/workspace/.env" ]; then
    log_output "✅ Archivo .env: ENCONTRADO"
    # Check APP_URL
    if grep -q "APP_URL=https://cps.qhosting.net" /workspace/.env; then
        log_output "✅ APP_URL: CONFIGURADO CORRECTAMENTE"
    else
        log_output "⚠️ APP_URL: CONFIGURACIÓN POSIBLEMENTE INCORRECTA"
        grep "APP_URL=" /workspace/.env | head -1
    fi
else
    log_output "❌ Archivo .env: NO ENCONTRADO"
fi

# Check storage permissions
if [ -d "/workspace/storage" ] && [ -w "/workspace/storage" ]; then
    log_output "✅ Permisos storage: CORRECTOS"
else
    log_output "❌ Permisos storage: INCORRECTOS"
fi

# Check ionCube loader
log_section "6. EXTENSIONES PHP CRÍTICAS"

if php -m | grep -q "ionCube Loader"; then
    log_output "✅ ionCube Loader: INSTALADO"
    IONCUBE_VERSION=$(php -v 2>&1 | grep -i "ioncube" | head -1)
    if [ ! -z "$IONCUBE_VERSION" ]; then
        log_output "   Versión ionCube: $IONCUBE_VERSION"
    fi
else
    log_output "❌ ionCube Loader: NO INSTALADO - PROBLEMA CRÍTICO"
fi

# Check required PHP extensions
PHP_EXTENSIONS=("mysqli" "pdo_mysql" "redis" "curl" "json" "mbstring" "openssl" "zip")
MISSING_EXTENSIONS=""

for ext in "${PHP_EXTENSIONS[@]}"; do
    if php -m | grep -q "^$ext$"; then
        log_output "✅ PHP Extension $ext: DISPONIBLE"
    else
        log_output "❌ PHP Extension $ext: FALTANTE"
        MISSING_EXTENSIONS="$MISSING_EXTENSIONS $ext"
    fi
done

# External connectivity test
log_section "7. CONECTIVIDAD EXTERNA"

# Test external domain
if curl -s -o /dev/null -w "%{http_code}" https://cps.qhosting.net >/tmp/external_test.txt 2>/dev/null; then
    EXT_HTTP_CODE=$(cat /tmp/external_test.txt)
    if [ "$EXT_HTTP_CODE" = "200" ] || [ "$EXT_HTTP_CODE" = "302" ] || [ "$EXT_HTTP_CODE" = "301" ]; then
        log_output "✅ Conectividad externa cps.qhosting.net: HTTP $EXT_HTTP_CODE (OK)"
    else
        log_output "⚠️ Conectividad externa cps.qhosting.net: HTTP $EXT_HTTP_CODE"
    fi
else
    log_output "❌ Conectividad externa cps.qhosting.net: FALLO DE CONEXIÓN"
fi

# Generate summary report
log_section "8. RESUMEN EJECUTIVO"

ERROR_COUNT=0
WARNING_COUNT=0

# Count errors and warnings from log
ERROR_COUNT=$(grep -c "❌" "$LOG_FILE" 2>/dev/null || echo 0)
WARNING_COUNT=$(grep -c "⚠️" "$LOG_FILE" 2>/dev/null || echo 0)

log_output "Problemas detectados:"
log_output "  Errores críticos: $ERROR_COUNT"
log_output "  Advertencias: $WARNING_COUNT"

if [ "$ERROR_COUNT" -eq 0 ] && [ "$WARNING_COUNT" -eq 0 ]; then
    log_output "🎉 ESTADO GENERAL: EXCELENTE - Sistema funcionando correctamente"
    OVERALL_STATUS="EXCELLENT"
elif [ "$ERROR_COUNT" -eq 0 ]; then
    log_output "✅ ESTADO GENERAL: BUENO - Sistema funcionando con advertencias menores"
    OVERALL_STATUS="GOOD"
elif [ "$ERROR_COUNT" -le 2 ]; then
    log_output "⚠️ ESTADO GENERAL: PROBLEMAS MENORES - Sistema parcialmente funcional"
    OVERALL_STATUS="MINOR_ISSUES"
else
    log_output "❌ ESTADO GENERAL: PROBLEMAS CRÍTICOS - Sistema requiere atención inmediata"
    OVERALL_STATUS="CRITICAL_ISSUES"
fi

# Create latest status file
cat > "$STATUS_FILE" << EOF
=== CPS POST-DEPLOY DIAGNOSTIC SUMMARY ===
Timestamp: $(date)
Overall Status: $OVERALL_STATUS
Errors: $ERROR_COUNT
Warnings: $WARNING_COUNT
Log File: $LOG_FILE

Last Check: $(date '+%Y-%m-%d %H:%M:%S')
Script Version: 1.0
Environment: Easypanel
Application: CPS License Management
EOF

# Quick recommendations
log_section "9. RECOMENDACIONES RÁPIDAS"

if [ "$ERROR_COUNT" -gt 0 ]; then
    log_output "🚨 ACCIÓN REQUERIDA: Revisar errores críticos antes de usar la aplicación"
    log_output "📋 Verificar: Logs detallados en $LOG_FILE"
elif [ "$WARNING_COUNT" -gt 0 ]; then
    log_output "⚠️ MONITOREO: Revisar advertencias para optimización futura"
else
    log_output "🎯 SISTEMA LISTO: Aplicación funcionando correctamente"
fi

log_output ""
log_output "=== DIAGNÓSTICO COMPLETADO ==="
log_output "Para análisis detallado, revisar: $LOG_FILE"
log_output "Estado actualizado en: $STATUS_FILE"
log_output "Timestamp finalización: $(date)"

# Display summary in console (for Easypanel log visibility)
echo ""
echo "=== CPS DIAGNOSTIC SUMMARY ==="
echo "Estado: $OVERALL_STATUS"
echo "Errores: $ERROR_COUNT | Advertencias: $WARNING_COUNT"
echo "Log completo: $LOG_FILE"
echo "Verificar acceso: https://cps.qhosting.net"
echo "============================"

exit 0