#!/bin/bash

# Script de despliegue con Docker - Sistema CPS
# Versión simplificada para EasyPanel y otros hosts

set -e

echo "🐳 Despliegue del Sistema CPS con Docker"
echo "======================================"

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }

# Verificar Docker
if ! command -v docker &> /dev/null; then
    print_error "Docker no está instalado. Instala Docker primero."
    exit 1
fi

print_success "Docker encontrado: $(docker --version)"

# Verificar docker-compose
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    print_error "Docker Compose no está instalado."
    exit 1
fi

# Usar docker compose (versión 2) o docker-compose
COMPOSE_CMD="docker-compose"
if docker compose version &> /dev/null; then
    COMPOSE_CMD="docker compose"
fi

print_success "Docker Compose encontrado: $($COMPOSE_CMD --version)"

# Crear directorio para logs si no existe
mkdir -p storage/logs
print_info "Directorio de logs creado"

# Crear archivo .env si no existe
if [ ! -f ".env" ]; then
    if [ -f ".env.easypanel" ]; then
        cp .env.easypanel .env
        print_warning "Archivo .env copiado desde .env.easypanel - CONFIGURA TUS CREDENCIALES"
    else
        print_error "Archivo .env no encontrado. Usar .env.easypanel como plantilla"
        exit 1
    fi
else
    print_info "Archivo .env existente encontrado"
fi

# Generar APP_KEY si no está configurado
if grep -q "APP_KEY=base64:GENERAR_CLAVE_AQUI" .env; then
    print_info "Generando APP_KEY..."
    # En construcción, se generará automáticamente en el contenedor
    print_warning "APP_KEY se generará automáticamente al iniciar el contenedor"
fi

print_info "Construyendo imagen Docker..."
$COMPOSE_CMD build --no-cache

print_info "Iniciando servicios..."
$COMPOSE_CMD up -d

# Esperar a que los servicios estén listos
print_info "Esperando a que los servicios estén listos..."
sleep 10

# Verificar estado de los contenedores
print_info "Verificando estado de los contenedores..."
$COMPOSE_CMD ps

# Verificar logs por errores
print_info "Verificando logs por errores..."
if $COMPOSE_CMD logs --tail=20 web | grep -i "error\|fatal"; then
    print_error "Se encontraron errores en el log del contenedor web"
    $COMPOSE_CMD logs --tail=50 web
fi

# Mostrar información de acceso
echo ""
echo "======================================"
print_success "¡Sistema CPS desplegado exitosamente!"
echo "======================================"
echo ""
print_info "URLS DE ACCESO:"
echo "• Sitio Principal: http://localhost"
echo "• Panel Admin: http://localhost/panel"
echo "• phpMyAdmin: http://localhost:8080"
echo "• Redis Insight: http://localhost:8001"
echo ""
print_info "CREDENCIALES DE BASE DE DATOS:"
echo "• Host: mysql"
echo "• Puerto: 3306"
echo "• Database: cps_db"
echo "• Usuario: cps_user"
echo "• Contraseña: cps_password"
echo "• Root: rootpassword"
echo ""
print_info "CREDENCIALES DE ACCESO INICIAL:"
echo "• Email: admin@admin.com"
echo "• Contraseña: 123456"
echo "• ⚠️ CAMBIAR INMEDIATAMENTE después del primer login"
echo ""
print_info "COMANDOS ÚTILES:"
echo "• Ver logs: $COMPOSE_CMD logs -f web"
echo "• Parar servicios: $COMPOSE_CMD down"
echo "• Reiniciar: $COMPOSE_CMD restart"
echo "• Shell en contenedor: $COMPOSE_CMD exec web bash"
echo ""

# Verificar si el sitio responde
print_info "Verificando conectividad..."
if curl -s http://localhost > /dev/null; then
    print_success "¡Sitio web respondiendo correctamente!"
else
    print_warning "El sitio no responde aún, puede tardar unos minutos más"
fi

echo ""
print_info "Para más información, ejecuta: $COMPOSE_CMD logs -f web"
print_info "======================================"