# CPS License Management System

Sistema completo de gestión de licencias cPanel desarrollado en Laravel 9.

## Descripción

Este es un sistema profesional de gestión de licencias para revendedores de cPanel que incluye:

- **Gestión de Licencias**: Creación, edición, renovación y revocación de licencias
- **Sistema de Pagos**: Integración con múltiples pasarelas de pago (Stripe, PayPal, SSLCommerz, UddoktaPay, Coinbase)
- **Gestión de Usuarios**: Sistema completo de usuarios con roles y permisos
- **Gestión de Resellers**: Sistema jerárquico de revendedores
- **Sistema de Tickets**: Gestión de soporte técnico
- **Panel de Administración**: Dashboard completo para administradores
- **API REST**: API para integraciones externas
- **Notificaciones**: Sistema de notificaciones por email

## Características Técnicas

- **Framework**: Laravel 9.x
- **PHP**: 8.0+
- **Base de Datos**: MySQL
- **Cache**: Redis
- **Frontend**: Blade templates con Bootstrap y jQuery
- **Autenticación**: Laravel Breeze/Jetstream
- **Protección de Código**: ionCube Loader (archivos encriptados)
- **Procesamiento de Pagos**: Stripe SDK, PayPal SDK
- **Notificaciones**: Laravel Notifications
- **Colas de Trabajo**: Laravel Horizon

## Instalación

### Requisitos del Sistema

- PHP 8.0 o superior
- Composer
- MySQL 5.7+ o MariaDB 10.3+
- Redis
- Apache/Nginx
- ionCube Loader (requerido para ejecutar archivos encriptados)

### Pasos de Instalación

1. **Clonar el repositorio**:
```bash
git clone https://github.com/qhosting/cps.git
cd cps
```

2. **Instalar dependencias**:
```bash
composer install
npm install
```

3. **Configurar variables de entorno**:
```bash
cp .env.example .env
php artisan key:generate
```

4. **Configurar la base de datos**:
Editar el archivo `.env` con las credenciales de la base de datos:
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=cps_database
DB_USERNAME=username
DB_PASSWORD=password
```

5. **Ejecutar migraciones**:
```bash
php artisan migrate
```

6. **Ejecutar seeders** (opcional):
```bash
php artisan db:seed
```

7. **Configurar permisos**:
```bash
chmod -R 755 storage/
chmod -R 755 bootstrap/cache/
```

8. **Configurar servidor web**:
Configurar el document root para apuntar a la carpeta `public/`.

## Configuración

### Variables de Entorno Principales

```env
# Aplicación
APP_NAME="CPS License Management"
APP_ENV=production
APP_KEY=
APP_DEBUG=false
APP_URL=http://yourdomain.com

# Base de Datos
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=cps_database
DB_USERNAME=username
DB_PASSWORD=password

# Redis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

# Mail
MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null

# Stripe
STRIPE_KEY=your_stripe_public_key
STRIPE_SECRET=your_stripe_secret_key

# PayPal
PAYPAL_CLIENT_ID=your_paypal_client_id
PAYPAL_CLIENT_SECRET=your_paypal_client_secret
PAYPAL_MODE=sandbox # o 'live' para producción
```

## Estructura del Proyecto

```
├── app/
│   ├── Http/Controllers/     # Controladores de la aplicación
│   ├── Models/              # Modelos de Eloquent
│   ├── Middleware/          # Middleware personalizado
│   ├── Notifications/       # Clases de notificación
│   └── ...
├── database/
│   ├── migrations/          # Migraciones de base de datos
│   └── seeders/            # Seeders para datos iniciales
├── resources/
│   ├── views/              # Vistas Blade
│   ├── lang/              # Archivos de idioma
│   └── ...
├── routes/
│   ├── web.php            # Rutas web
│   └── api.php            # Rutas API
├── public/
│   ├── assets/            # CSS, JS, imágenes
│   └── plugins/           # Librerías externas
└── composer.json          # Dependencias PHP
```

## Características Principales

### 1. Gestión de Licencias
- Creación y edición de licencias
- Renovación automática
- Control de expiración
- Validación de licencias

### 2. Sistema de Pagos
- **Stripe**: Pagos con tarjetas de crédito/débito
- **PayPal**: Pagos con cuenta PayPal
- **SSLCommerz**: Pasarela de pago local
- **UddoktaPay**: Pasarela de pago bangladesí
- **Coinbase**: Pagos con criptomonedas

### 3. Gestión de Usuarios
- Registro y autenticación
- Perfiles de usuario
- Roles y permisos
- Sistema de verificación

### 4. Panel de Administración
- Dashboard con estadísticas
- Gestión de usuarios y permisos
- Configuración del sistema
- Logs y auditoría

### 5. API REST
- Endpoints para gestión de licencias
- Autenticación por API tokens
- Documentación de API

## Uso

### Comandos Artisan Útiles

```bash
# Generar una nueva clave de aplicación
php artisan key:generate

# Limpiar cache de configuración
php artisan config:clear

# Ejecutar migraciones
php artisan migrate

# Ver logs de la aplicación
php artisan tail

# Ejecutar queue worker
php artisan queue:work

# Procesar trabajos en cola
php artisan horizon
```

### Estructura de URLs Principales

- `/` - Página de inicio
- `/login` - Inicio de sesión
- `/register` - Registro de usuarios
- `/dashboard` - Panel principal
- `/licenses` - Gestión de licencias
- `/payments` - Historial de pagos
- `/support` - Sistema de tickets

## Seguridad

- Validación de datos en todos los formularios
- Autenticación y autorización robusta
- Protección CSRF en formularios
- Sanitización de inputs
- Encriptación de datos sensibles
- Rate limiting en API

## Soporte

Para soporte técnico o consultas:

1. Revisar la documentación
2. Consultar los logs de la aplicación
3. Contactar al equipo de desarrollo

## Licencia

Este proyecto está bajo licencia propietaria. Todos los derechos reservados.

## Créditos

Desarrollado por el equipo de QHosting
GitHub: https://github.com/qhosting/cps

---

**Nota**: Este sistema requiere ionCube Loader para funcionar correctamente debido a la protección de código implementada.