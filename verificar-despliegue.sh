#!/bin/bash

echo "=== VERIFICACIÓN COMPLETA DEL DESPLIEGUE ==="
echo "Fecha: $(date)"
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${NC}"
    else
        echo -e "${RED}✗ $2${NC}"
    fi
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

echo "1. VERIFICANDO CONFIGURACIÓN DEL REPOSITORIO"
echo "============================================"

# Verificar campos de configuración
print_info "Campos que deben estar configurados en el panel:"
echo "   Owner: qhosting"
echo "   Repository: cps"
echo "   Branch: main (¡IMPORTANTE!)"
echo "   Build Path: /"
echo ""

echo "2. VERIFICANDO CONECTIVIDAD CON GITHUB"
echo "======================================"

# Test básico de conectividad
if curl -s --max-time 10 https://github.com > /dev/null; then
    print_status 0 "Conectividad a GitHub"
else
    print_status 1 "Conectividad a GitHub"
fi

# Verificar API de GitHub
if curl -s --max-time 10 https://api.github.com > /dev/null; then
    print_status 0 "API de GitHub accesible"
else
    print_status 1 "API de GitHub no accesible"
fi

echo ""
echo "3. VERIFICANDO ESTADO DEL REPOSITORIO"
echo "====================================="

# Verificar acceso al repositorio (sin autenticación para repos públicos)
if curl -s --max-time 10 https://github.com/qhosting/cps > /dev/null; then
    print_status 0 "Repositorio público accesible"
else
    print_warning "Repositorio podría estar configurado como privado"
fi

echo ""
echo "4. CONFIGURACIÓN DEL TOKEN DE GITHUB"
echo "===================================="

print_warning "Verificar en Ajustes del panel:"
echo "   1. Token: [TU_GITHUB_TOKEN_AQUÍ]"
echo "   2. Scopes requeridos: repo (acceso completo al repositorio)"
echo "   3. El token debe tener permisos para el repositorio qhosting/cps"
echo ""

echo "5. SOLUCIONES SUGERIDAS"
echo "======================="

echo -e "${YELLOW}Si el error 'Branch not found' persiste, intentar:${NC}"
echo ""
echo "A. Verificar el nombre exacto de la rama:"
echo "   - Asegúrate de que es 'main' (no 'master' o 'master-main')"
echo "   - Si tu rama principal es diferente, usa ese nombre"
echo ""
echo "B. Verificar permisos del token:"
echo "   - El token debe tener scope 'repo'"
echo "   - Para repos privados, debe tener permisos específicos"
echo ""
echo "C. Configuración alternativa:"
echo "   - Intenta con Branch: master (si existe)"
echo "   - Intenta con Branch: (vacío, para usar default)"
echo ""

echo "6. VERIFICACIÓN MANUAL EN GITHUB"
echo "================================="

print_info "Para verificar manualmente:"
echo "1. Ve a: https://github.com/qhosting/cps"
echo "2. Verifica que el repositorio existe"
echo "3. En el dropdown de ramas, verifica que existe 'main'"
echo "4. Si no existe 'main', cambia a 'master' o la rama que sí existe"
echo ""

echo "7. PRÓXIMOS PASOS RECOMENDADOS"
echo "=============================="

print_info "Si la configuración es correcta:"
echo "1. Guarda la configuración del panel"
echo "2. El sistema debería comenzar a clonar el repositorio"
echo "3. Verifica los logs del proceso de despliegue"
echo "4. El despliegue puede tomar 2-5 minutos la primera vez"
echo ""

echo -e "${GREEN}=== FIN DE LA VERIFICACIÓN ===${NC}"
echo ""
echo "Si necesitas ayuda adicional, proporciona:"
echo "1. Captura de pantalla actual del panel"
echo "2. URL exacta del repositorio que ves en GitHub"
echo "3. Lista de ramas disponibles en el dropdown del repositorio"