#!/bin/bash

# ==============================================================================
# SCRIPT DE IMPLEMENTACIÓN AUTOMÁTICA - SOLUCIÓN ERRORES EASYPANEL
# 
# Este script aplica automáticamente todas las correcciones para solucionar
# los errores identificados en el despliegue de CPS en EasyPanel.
# 
# Uso: ./implementar-solucion-errores.sh
# ==============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Función para imprimir mensajes
print_header() {
    echo
    echo -e "${PURPLE}===================================================${NC}"
    echo -e "${PURPLE} $1${NC}"
    echo -e "${PURPLE}===================================================${NC}"
    echo
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✅ SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[⚠️  WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[❌ ERROR]${NC} $1"
}

print_check() {
    echo -e "${CYAN}[CHECK]${NC} $1"
}

# Función para verificar si un archivo existe
check_file_exists() {
    if [ -f "$1" ]; then
        print_success "Archivo encontrado: $1"
        return 0
    else
        print_error "Archivo no encontrado: $1"
        return 1
    fi
}

# Función para crear backup
create_backup() {
    print_header "CREANDO BACKUP DE ARCHIVOS ACTUALES"
    
    local backup_dir="backup-$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    local files_to_backup=(
        "Dockerfile"
        "docker-compose.yml" 
        "docker/entrypoint.sh"
        "docker/supervisord.conf"
        "docker/php.ini"
        "php.ini"
    )
    
    local backed_up=0
    for file in "${files_to_backup[@]}"; do
        if [ -f "$file" ]; then
            cp "$file" "$backup_dir/"
            print_success "Backup creado: $backup_dir/$file"
            backed_up=$((backed_up + 1))
        else
            print_warning "Archivo no existe: $file"
        fi
    done
    
    if [ $backed_up -gt 0 ]; then
        print_success "Backup completado en: $backup_dir"
    else
        print_warning "No se crearon backups (no hay archivos para respaldar)"
        rm -rf "$backup_dir"
    fi
}

# Función para aplicar correcciones
apply_fixes() {
    print_header "APLICANDO CORRECCIONES"
    
    local fixes_applied=0
    
    # 1. Dockerfile
    print_check "Aplicando Dockerfile corregido..."
    if check_file_exists "Dockerfile.corregido"; then
        cp "Dockerfile.corregido" "Dockerfile"
        print_success "Dockerfile aplicado"
        fixes_applied=$((fixes_applied + 1))
    else
        print_error "Dockerfile.corregido no encontrado"
    fi
    
    # 2. Docker Compose
    print_check "Aplicando docker-compose corregido..."
    if check_file_exists "docker-compose-corregido.yml"; then
        cp "docker-compose-corregido.yml" "docker-compose.yml"
        print_success "docker-compose.yml aplicado"
        fixes_applied=$((fixes_applied + 1))
    else
        print_error "docker-compose-corregido.yml no encontrado"
    fi
    
    # 3. Entrypoint
    print_check "Aplicando entrypoint corregido..."
    if check_file_exists "docker/entrypoint-fixed.sh"; then
        cp "docker/entrypoint-fixed.sh" "docker/entrypoint.sh"
        chmod +x "docker/entrypoint.sh"
        print_success "entrypoint.sh aplicado"
        fixes_applied=$((fixes_applied + 1))
    else
        print_error "docker/entrypoint-fixed.sh no encontrado"
    fi
    
    # 4. Supervisord
    print_check "Aplicando supervisord corregido..."
    if check_file_exists "docker/supervisord-corregido.conf"; then
        cp "docker/supervisord-corregido.conf" "docker/supervisord.conf"
        print_success "supervisord.conf aplicado"
        fixes_applied=$((fixes_applied + 1))
    else
        print_error "docker/supervisord-corregido.conf no encontrado"
    fi
    
    # 5. PHP.ini
    print_check "Aplicando php.ini corregido..."
    if check_file_exists "docker/php.ini.production"; then
        cp "docker/php.ini.production" "php.ini"
        print_success "php.ini aplicado"
        fixes_applied=$((fixes_applied + 1))
    else
        print_error "docker/php.ini.production no encontrado"
    fi
    
    print_success "Correcciones aplicadas: $fixes_applied"
    
    if [ $fixes_applied -eq 0 ]; then
        print_error "No se aplicaron correcciones"
        return 1
    fi
    
    return 0
}

# Función para verificar configuración
verify_configuration() {
    print_header "VERIFICANDO CONFIGURACIÓN"
    
    local errors=0
    
    # Verificar variables críticas
    print_check "Verificando variables críticas..."
    local critical_files=(
        "Dockerfile"
        "docker-compose.yml"
        "docker/entrypoint.sh"
        "docker/supervisord.conf"
        "php.ini"
    )
    
    for file in "${critical_files[@]}"; do
        if ! check_file_exists "$file"; then
            errors=$((errors + 1))
        fi
    done
    
    # Verificar estructura de Laravel
    print_check "Verificando estructura de Laravel..."
    local laravel_files=("artisan" "composer.json" "public/index.php" "config/app.php")
    
    for file in "${laravel_files[@]}"; do
        if check_file_exists "$file"; then
            print_success "Laravel: $file"
        else
            print_error "Laravel: $file faltante"
            errors=$((errors + 1))
        fi
    done
    
    return $errors
}

# Función para mostrar variables de entorno
show_env_vars() {
    print_header "VARIABLES DE ENTORNO REQUERIDAS"
    
    print_info "Asegúrate de que estas variables estén configuradas en EasyPanel:"
    echo
    echo -e "${CYAN}APP_NAME = CPS${NC}"
    echo -e "${CYAN}APP_ENV = production${NC}"
    echo -e "${CYAN}APP_DEBUG = false${NC}"
    echo -e "${CYAN}APP_LICENSE = licensing_YMks1531pjbNIndSEobc${NC}"
    echo -e "${CYAN}API_TOKEN = 31535385afb2c62faa927f42ea346f04${NC}"
    echo -e "${CYAN}MAIL_HOST = smtp.tu-proveedor-email.com${NC}"
    echo -e "${CYAN}MAIL_USERNAME = tu-email@dominio.com${NC}"
    echo -e "${CYAN}MAIL_PASSWORD = tu_password_email${NC}"
    echo
    print_info "Para configurar: EasyPanel → Proyecto CPS → Configuración → Variables de Entorno"
}

# Función para mostrar pasos finales
show_final_steps() {
    print_header "PRÓXIMOS PASOS PARA IMPLEMENTAR"
    
    echo -e "${GREEN}1. RE-DESPLIEGUE EN EASYPANEL:${NC}"
    echo "   - Ve a EasyPanel → Proyecto CPS"
    echo "   - Haz clic en 'Re-desplegar' o 'Reiniciar'"
    echo "   - Espera a que termine el proceso (2-5 minutos)"
    echo
    
    echo -e "${GREEN}2. VERIFICACIÓN:${NC}"
    echo "   - Ejecuta: php check-env-rapido.php"
    echo "   - O usa: bash comandos-debug-easypanel.sh"
    echo "   - Accede a tu dominio para verificar que funciona"
    echo
    
    echo -e "${GREEN}3. MONITOREO:${NC}"
    echo "   - Revisa los logs: docker logs cps_app"
    echo "   - Verifica servicios: docker-compose ps"
    echo "   - Si hay problemas, ejecuta: bash comandos-debug-easypanel.sh report"
    echo
    
    echo -e "${YELLOW}🎯 RESULTADO ESPERADO:${NC}"
    echo "✅ Sin segmentation faults"
    echo "✅ ionCube funcionando correctamente"
    echo "✅ Todas las extensiones PHP cargadas"
    echo "✅ artisan encontrado"
    echo "✅ Supervisord ejecutándose"
    echo "✅ Aplicación CPS accesible en tu dominio"
    echo
    
    echo -e "${CYAN}🔗 ACCESOS:${NC}"
    echo "• Aplicación: http://tu-dominio.com/"
    echo "• phpMyAdmin: http://tu-dominio.com:8080"
    echo "• Redis Insight: http://tu-dominio.com:8001"
    echo
}

# Función principal
main() {
    print_header "IMPLEMENTACIÓN AUTOMÁTICA - SOLUCIÓN ERRORES EASYPANEL"
    
    print_info "Este script aplicará automáticamente todas las correcciones para los errores de despliegue"
    print_info "Versión: $(date)"
    
    # Verificar que estamos en el directorio correcto
    if [ ! -f "artisan" ]; then
        print_error "No se detectó proyecto Laravel en el directorio actual"
        print_info "Ejecuta este script desde el directorio raíz del proyecto CPS"
        exit 1
    fi
    
    # Paso 1: Crear backup
    create_backup
    echo
    
    # Paso 2: Aplicar correcciones
    if ! apply_fixes; then
        print_error "Error aplicando correcciones"
        exit 1
    fi
    echo
    
    # Paso 3: Verificar configuración
    if ! verify_configuration; then
        print_warning "Se encontraron algunos errores en la verificación"
        print_info "Revisa los mensajes anteriores y corrige antes de continuar"
    else
        print_success "Configuración verificada correctamente"
    fi
    echo
    
    # Paso 4: Mostrar variables requeridas
    show_env_vars
    echo
    
    # Paso 5: Mostrar pasos finales
    show_final_steps
    
    print_success "🎉 Implementación de correcciones completada!"
    print_info "Ahora procede con el re-despliegue en EasyPanel"
}

# Menú interactivo
show_menu() {
    echo
    print_header "MENU DE IMPLEMENTACIÓN"
    echo "1) Implementar todas las correcciones (recomendado)"
    echo "2) Solo crear backup"
    echo "3) Solo aplicar correcciones"
    echo "4) Solo verificar configuración"
    echo "5) Ver variables requeridas"
    echo "6) Ver pasos finales"
    echo "0) Salir"
    echo
    read -p "Selecciona una opción: " choice
    
    case $choice in
        1)
            print_header "IMPLEMENTACIÓN COMPLETA"
            create_backup && apply_fixes && verify_configuration && show_env_vars && show_final_steps
            ;;
        2)
            create_backup
            ;;
        3)
            apply_fixes
            ;;
        4)
            verify_configuration
            ;;
        5)
            show_env_vars
            ;;
        6)
            show_final_steps
            ;;
        0)
            print_info "Saliendo..."
            exit 0
            ;;
        *)
            print_error "Opción inválida"
            ;;
    esac
}

# Verificar dependencias
command -v docker >/dev/null 2>&1 || { print_warning "Docker no está disponible en este contenedor"; }
command -v nc >/dev/null 2>&1 || { print_warning "netcat (nc) no está instalado. Algunas verificaciones pueden fallar."; }

# Ejecutar función principal
if [ $# -gt 0 ]; then
    # Ejecutar función específica si se proporciona argumento
    case $1 in
        "backup") create_backup ;;
        "fix") apply_fixes ;;
        "verify") verify_configuration ;;
        "env") show_env_vars ;;
        "steps") show_final_steps ;;
        "menu") show_menu ;;
        *) print_error "Opción desconocida: $1" ;;
    esac
else
    # Ejecutar implementación completa
    main
fi