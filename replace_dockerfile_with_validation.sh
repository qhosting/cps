#!/bin/bash
# Script para reemplazar el Dockerfile original con la versión que incluye validación
# Autor: MiniMax Agent
# Fecha: 2025-12-10

set -e

echo "🔄 REEMPLAZANDO DOCKERFILE PARA EASYPANEL VALIDATION"
echo "=================================================="

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_step() {
    echo -e "${BLUE}🔧 $1${NC}"
}

# Verificar que estamos en el directorio correcto
if [[ ! -f "system/composer.json" ]]; then
    log_error "No se encontró system/composer.json. Ejecuta este script desde el directorio raíz del proyecto."
    exit 1
fi

# Crear backup del Dockerfile original
if [[ -f "Dockerfile" ]]; then
    log_step "Creando backup del Dockerfile original..."
    cp Dockerfile "Dockerfile.backup.$(date +%Y%m%d_%H%M%S)"
    log_info "Backup creado: Dockerfile.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Verificar que el nuevo Dockerfile existe
if [[ ! -f "Dockerfile-FINAL" ]]; then
    log_error "No se encontró Dockerfile-FINAL. Asegúrate de que esté en el directorio actual."
    exit 1
fi

# Reemplazar el Dockerfile
log_step "Reemplazando Dockerfile con la versión que incluye validación..."
cp Dockerfile-FINAL Dockerfile
log_info "Dockerfile reemplazado exitosamente"

# Verificar que validation-scripts existe
if [[ ! -d "validation-scripts" ]]; then
    log_error "No se encontró el directorio validation-scripts. Asegúrate de que esté presente."
    exit 1
fi

log_info "Scripts de validación detectados en validation-scripts/"

# Verificar el nuevo script de validación Docker
if [[ -f "validation-scripts/docker_build_validation.sh" ]]; then
    log_info "Script de validación Docker encontrado"
else
    log_warning "Script de validación Docker no encontrado"
fi

echo ""
echo "=================================================="
echo "🎯 REEMPLAZO COMPLETADO"
echo "=================================================="
echo ""
echo "📋 ACCIONES REALIZADAS:"
echo "- ✅ Dockerfile original respaldado"
echo "- ✅ Dockerfile reemplazado con versión de validación"
echo "- ✅ Scripts de validación disponibles"
echo ""
echo "🔄 PRÓXIMOS PASOS:"
echo "1. Revisa el nuevo Dockerfile si deseas"
echo "2. Sube los cambios a GitHub"
echo "3. Ejecuta un nuevo deploy en Easypanel"
echo "4. Observa la validación automática en el build log"
echo ""
echo "📊 LO QUE VERÁS EN EL BUILD:"
echo "- '=== EASYPANEL POST-DEPLOY VALIDATION ==='"
echo "- Validación de estructura Laravel"
echo "- Verificación de ionCube Loader"
echo "- Comprobación de extensiones PHP"
echo "- Validación de permisos"
echo "- Resumen de configuración"
echo ""
echo "💡 BENEFICIOS:"
echo "- Validación automática en cada deploy"
echo "- Detección temprana de problemas"
echo "- Logs visibles en Easypanel console"
echo "- Build fails si hay errores críticos"
echo ""

# Preguntar si desea hacer commit
read -p "¿Deseas hacer commit y push de estos cambios? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    log_step "Haciendo commit y push de los cambios..."
    
    git add Dockerfile validation-scripts/
    git commit -m "feat: Add Docker build validation for Easypanel

- Replace Dockerfile with validation-enabled version
- Add docker_build_validation.sh for build-time checks
- Enable automatic validation during Easypanel deploys
- Validate Laravel structure, ionCube, PHP extensions, and permissions"
    
    git push origin master
    
    log_info "Cambios enviados a GitHub exitosamente"
    echo ""
    echo "🚀 LISTO PARA NUEVO DEPLOY EN EASYPANEL"
else
    log_info "Cambios guardados localmente. Puedes hacer commit manualmente cuando desees."
fi

echo ""
echo "=================================================="