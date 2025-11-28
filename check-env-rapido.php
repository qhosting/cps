<?php
/**
 * VERIFICACIÓN RÁPIDA DE VARIABLES DE ENTORNO - EASYPANEL CPS
 * 
 * Este script verifica rápidamente el estado de las variables de entorno
 * y proporciona un resumen del estado del sistema.
 * 
 * Uso: php check-env-rapido.php
 * 
 * Para acceder vía web: Coloca este archivo en public/ y accede a /check-env-rapido.php
 */

header('Content-Type: text/html; charset=utf-8');

// Configuración de colores para terminal
$colors = [
    'header' => "\033[1;34m",
    'success' => "\033[1;32m", 
    'warning' => "\033[1;33m",
    'error' => "\033[1;31m",
    'info' => "\033[1;36m",
    'reset' => "\033[0m"
];

function print_header($text, $colors) {
    echo $colors['header'] . str_repeat('=', strlen($text) + 4) . $colors['reset'] . "\n";
    echo $colors['header'] . "  " . $text . "  " . $colors['reset'] . "\n";
    echo $colors['header'] . str_repeat('=', strlen($text) + 4) . $colors['reset'] . "\n\n";
}

function print_status($status, $text, $colors) {
    $symbols = [
        'success' => '✅',
        'warning' => '⚠️', 
        'error' => '❌',
        'info' => 'ℹ️'
    ];
    
    echo $colors[$status] . $symbols[$status] . " $text" . $colors['reset'] . "\n";
}

function format_value($value, $sensitive = false) {
    if (empty($value)) {
        return '[VACÍO]';
    }
    
    if ($sensitive) {
        return substr($value, 0, 8) . '...';
    }
    
    return $value;
}

function check_connection($host, $port, $name) {
    try {
        $connection = @fsockopen($host, $port, $errno, $errstr, 2);
        if ($connection) {
            fclose($connection);
            return ['status' => 'success', 'message' => "Conectado a $name ($host:$port)"];
        }
    } catch (Exception $e) {
        return ['status' => 'error', 'message' => "Error conectando a $name: " . $e->getMessage()];
    }
    
    return ['status' => 'error', 'message' => "No se pudo conectar a $name ($host:$port)"];
}

// Detectar si es web o terminal
$is_web = !empty($_SERVER['HTTP_HOST']);

if ($is_web) {
    echo '<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verificación de Variables - EasyPanel CPS</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; margin-bottom: 20px; }
        .section { margin: 20px 0; }
        .section h3 { color: #34495e; margin-bottom: 10px; }
        .status { padding: 8px 12px; margin: 5px 0; border-radius: 4px; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .warning { background: #fff3cd; color: #856404; border: 1px solid #ffeaa7; }
        .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        table { width: 100%; border-collapse: collapse; margin: 10px 0; }
        th, td { padding: 8px 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; }
        .masked { color: #6c757d; font-family: monospace; }
        .timestamp { color: #6c757d; font-style: italic; }
    </style>
</head>
<body>
<div class="container">
    <h1 class="header">🔍 Verificación de Variables de Entorno - EasyPanel CPS</h1>
    <p class="timestamp">Generado: ' . date('Y-m-d H:i:s') . '</p>
';
} else {
    print_header("VERIFICACIÓN DE VARIABLES - EASYPANEL CPS", $colors);
    echo $colors['info'] . "Generado: " . date('Y-m-d H:i:s') . $colors['reset'] . "\n\n";
}

// Variables críticas
$critical_vars = [
    'APP_NAME' => ['sensitive' => false, 'required' => true],
    'APP_ENV' => ['sensitive' => false, 'required' => true],
    'APP_KEY' => ['sensitive' => true, 'required' => true],
    'APP_DEBUG' => ['sensitive' => false, 'required' => true],
    'APP_URL' => ['sensitive' => false, 'required' => true],
    'DB_HOST' => ['sensitive' => false, 'required' => true],
    'DB_DATABASE' => ['sensitive' => false, 'required' => true],
    'DB_USERNAME' => ['sensitive' => true, 'required' => true],
    'DB_PASSWORD' => ['sensitive' => true, 'required' => true],
    'REDIS_HOST' => ['sensitive' => false, 'required' => true],
    'REDIS_PORT' => ['sensitive' => false, 'required' => true],
    'MAIL_HOST' => ['sensitive' => false, 'required' => true],
    'MAIL_USERNAME' => ['sensitive' => true, 'required' => true],
    'MAIL_PASSWORD' => ['sensitive' => true, 'required' => true],
];

// Variables de EasyPanel
$easypanel_vars = ['EASYPANEL', 'EASYPANEL_PROJECT', 'EASYPANEL_DOMAIN', 'HOST', 'PORT'];

if ($is_web) {
    echo '<div class="section">';
    echo '<h3>🔧 Variables Críticas del Sistema</h3>';
} else {
    print_header("VARIABLES CRÍTICAS DEL SISTEMA", $colors);
}

$missing_vars = [];
$present_vars = [];

foreach ($critical_vars as $var => $config) {
    $value = getenv($var);
    
    if (empty($value)) {
        if ($config['required']) {
            if ($is_web) {
                echo '<div class="status error">❌ ' . $var . ': NO DEFINIDA (REQUERIDA)</div>';
            } else {
                print_status('error', $var . ': NO DEFINIDA (REQUERIDA)', $colors);
            }
            $missing_vars[] = $var;
        } else {
            if ($is_web) {
                echo '<div class="status warning">⚠️ ' . $var . ': NO DEFINIDA (OPCIONAL)</div>';
            } else {
                print_status('warning', $var . ': NO DEFINIDA (OPCIONAL)', $colors);
            }
        }
    } else {
        if ($is_web) {
            $display_value = $config['sensitive'] ? '<span class="masked">' . format_value($value, true) . '</span>' : format_value($value);
            echo '<div class="status success">✅ ' . $var . ': ' . $display_value . '</div>';
        } else {
            print_status('success', $var . ': ' . format_value($value, $config['sensitive']), $colors);
        }
        $present_vars[] = $var;
    }
}

if ($is_web) {
    echo '</div>';
} else {
    echo "\n";
}

// Verificar variables de EasyPanel
if ($is_web) {
    echo '<div class="section">';
    echo '<h3>🌐 Variables de EasyPanel</h3>';
} else {
    print_header("VARIABLES DE EASYPANEL", $colors);
}

foreach ($easypanel_vars as $var) {
    $value = getenv($var);
    if ($is_web) {
        if (!empty($value)) {
            echo '<div class="status success">✅ ' . $var . ': ' . format_value($value) . '</div>';
        } else {
            echo '<div class="status warning">⚠️ ' . $var . ': NO DISPONIBLE</div>';
        }
    } else {
        if (!empty($value)) {
            print_status('success', $var . ': ' . format_value($value), $colors);
        } else {
            print_status('warning', $var . ': NO DISPONIBLE', $colors);
        }
    }
}

if ($is_web) {
    echo '</div>';
} else {
    echo "\n";
}

// Verificar conectividad
if ($is_web) {
    echo '<div class="section">';
    echo '<h3>🔌 Conectividad de Servicios</h3>';
} else {
    print_header("CONECTIVIDAD DE SERVICIOS", $colors);
}

$services = [
    ['host' => getenv('DB_HOST') ?: 'mysql', 'port' => getenv('DB_PORT') ?: '3306', 'name' => 'MySQL'],
    ['host' => getenv('REDIS_HOST') ?: 'redis', 'port' => getenv('REDIS_PORT') ?: '6379', 'name' => 'Redis']
];

foreach ($services as $service) {
    $result = check_connection($service['host'], $service['port'], $service['name']);
    
    if ($is_web) {
        $status_class = $result['status'] === 'success' ? 'success' : 'error';
        echo '<div class="status ' . $status_class . '">' . 
             ($result['status'] === 'success' ? '✅' : '❌') . ' ' . 
             $result['message'] . '</div>';
    } else {
        print_status($result['status'], $result['message'], $colors);
    }
}

if ($is_web) {
    echo '</div>';
} else {
    echo "\n";
}

// Verificar extensiones PHP
if ($is_web) {
    echo '<div class="section">';
    echo '<h3>🐘 Extensiones PHP</h3>';
} else {
    print_header("EXTENSIONES PHP", $colors);
}

$extensions = ['pdo', 'pdo_mysql', 'redis', 'curl', 'json', 'mbstring', 'zip', 'openssl'];
foreach ($extensions as $ext) {
    $loaded = extension_loaded($ext);
    
    if ($is_web) {
        $status_class = $loaded ? 'success' : 'error';
        echo '<div class="status ' . $status_class . '">' . 
             ($loaded ? '✅' : '❌') . ' ' . 
             $ext . ': ' . ($loaded ? 'Cargada' : 'NO DISPONIBLE') . '</div>';
    } else {
        print_status($loaded ? 'success' : 'error', $ext . ': ' . ($loaded ? 'Cargada' : 'NO DISPONIBLE'), $colors);
    }
}

// Verificar ionCube
if ($is_web) {
    echo '<div class="status info">ℹ️ ionCube: ' . (phpversion('ionCube Loader') ? 'Cargado (' . phpversion('ionCube Loader') . ')' : 'NO DETECTADO') . '</div>';
} else {
    print_status(phpversion('ionCube Loader') ? 'success' : 'warning', 
                'ionCube: ' . (phpversion('ionCube Loader') ? 'Cargado (' . phpversion('ionCube Loader') . ')' : 'NO DETECTADO'), 
                $colors);
}

if ($is_web) {
    echo '</div>';
} else {
    echo "\n";
}

// Resumen final
if ($is_web) {
    echo '<div class="section">';
    echo '<h3>📊 Resumen</h3>';
    
    if (empty($missing_vars)) {
        echo '<div class="status success">🎉 Todas las variables críticas están configuradas correctamente</div>';
    } else {
        echo '<div class="status error">❌ Variables faltantes: ' . implode(', ', $missing_vars) . '</div>';
    }
    
    echo '<p><strong>Variables verificadas:</strong> ' . count($present_vars) . '/' . count($critical_vars) . '</p>';
    echo '<p><strong>Última actualización:</strong> ' . date('Y-m-d H:i:s') . '</p>';
    echo '</div>';
    
    echo '<div class="section">';
    echo '<h3>🔗 Enlaces Útiles</h3>';
    echo '<ul>';
    echo '<li><a href="./">Volver al inicio</a></li>';
    echo '<li><a href="../storage/logs/laravel.log" target="_blank">Ver logs de Laravel</a></li>';
    echo '<li><a href="phpinfo.php">Información detallada de PHP</a></li>';
    echo '</ul>';
    echo '</div>';
    
    echo '</div></body></html>';
} else {
    print_header("RESUMEN FINAL", $colors);
    
    if (empty($missing_vars)) {
        print_status('success', '🎉 Todas las variables críticas están configuradas', $colors);
    } else {
        print_status('error', '❌ Variables faltantes: ' . implode(', ', $missing_vars), $colors);
    }
    
    echo $colors['info'] . "Variables verificadas: " . count($present_vars) . "/" . count($critical_vars) . $colors['reset'] . "\n";
    echo $colors['info'] . "Para más información, consulta las guías en el workspace." . $colors['reset'] . "\n";
}

// Crear archivo de información adicional
$debug_info = [
    'timestamp' => date('Y-m-d H:i:s'),
    'php_version' => phpversion(),
    'laravel_version' => function_exists('app') ? app()->version() : 'No detectado',
    'easypanel_vars' => [],
    'missing_vars' => $missing_vars,
    'extensions' => get_loaded_extensions(),
    'memory_usage' => memory_get_usage(true),
    'max_execution_time' => ini_get('max_execution_time')
];

foreach ($easypanel_vars as $var) {
    $debug_info['easypanel_vars'][$var] = getenv($var);
}

file_put_contents('debug-info.json', json_encode($debug_info, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
?>
