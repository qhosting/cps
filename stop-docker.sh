#!/bin/bash

# Script para detener y limpiar servicios Docker - Sistema CPS

set -e

echo "🛑 Deteniendo Sistema CPS - Docker"
echo "==============================="

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

# Verificar docker-compose
COMPOSE_CMD="docker-compose"
if docker compose version &> /dev/null; then
    COMPOSE_CMD="docker compose"
fi

# Función para mostrar menú
show_menu() {
    echo ""
    echo "Selecciona una opción:"
    echo "1) Solo detener servicios (mantener datos)"
    echo "2) Detener y eliminar contenedores"
    echo "3) Detener, eliminar contenedores e imágenes"
    echo "4) Detener, eliminar todo (incluyendo volúmenes)"
    echo "5) Solo ver estado"
    echo "6) Cancelar"
    echo ""
    read -p "Opción [1-6]: " option
}

# Mostrar estado actual
print_info "Estado actual de los contenedores:"
$COMPOSE_CMD ps

# Mostrar menú
show_menu

case $option in
    1)
        print_info "Deteniendo servicios..."
        $COMPOSE_CMD stop
        print_success "Servicios detenidos. Para reiniciar: $COMPOSE_CMD start"
        ;;
    2)
        print_warning "Deteniendo y eliminando contenedores..."
        $COMPOSE_CMD down
        print_success "Contenedores eliminados. Para reiniciar: $COMPOSE_CMD up -d"
        ;;
    3)
        print_warning "Deteniendo y eliminando contenedores e imágenes..."
        $COMPOSE_CMD down --rmi all
        print_success "Contenedores e imágenes eliminados. Para reiniciar: $COMPOSE_CMD up -d --build"
        ;;
    4)
        print_warning "Deteniendo y eliminando TODO (incluyendo volúmenes con datos)..."
        echo "⚠️  ATENCIÓN: Esto eliminará TODOS los datos de la base de datos"
        read -p "¿Estás seguro? (yes/no): " confirm
        if [ "$confirm" = "yes" ]; then
            $COMPOSE_CMD down --volumes --remove-orphans
            print_success "Todo eliminado completamente"
        else
            print_info "Operación cancelada"
        fi
        ;;
    5)
        print_info "Estado actual:"
        $COMPOSE_CMD ps
        print_info "Uso de recursos:"
        docker stats --no-stream $(docker ps --format "{{.Names}}" | grep cps) 2>/dev/null || print_info "No hay contenedores cps ejecutándose"
        ;;
    6)
        print_info "Operación cancelada"
        exit 0
        ;;
    *)
        print_error "Opción inválida"
        exit 1
        ;;
esac

echo ""
print_info "COMANDOS ÚTILES:"
echo "• Ver estado: $COMPOSE_CMD ps"
echo "• Reiniciar: $COMPOSE_CMD start"
echo "• Reiniciar todo: $COMPOSE_CMD up -d"
echo "• Ver logs: $COMPOSE_CMD logs -f"
echo "• Shell en contenedor: $COMPOSE_CMD exec web bash"
echo ""

# Mostrar información de limpieza de Docker
print_info "Para limpiar recursos no utilizados de Docker:"
echo "docker system prune -a"
echo "docker volume prune"
echo ""

print_success "Operación completada"