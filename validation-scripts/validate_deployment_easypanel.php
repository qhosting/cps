<?php
/**
 * CPS Validation Script for Easypanel Deployment
 * 
 * This script validates the CPS system deployment in Easypanel environment
 * Easypanel uses port 3000 internally with reverse proxy to domain
 */

class CPSEasypanelValidator {
    private $errors = [];
    private $warnings = [];
    private $success = [];
    
    private $config = [
        'app_url' => 'https://cps.qhosting.net',
        'internal_url' => 'http://localhost:3000',
        'internal_port' => 3000,
        'database' => [
            'host' => '127.0.0.1',
            'port' => 3306,
            'database' => 'cps_database'
        ],
        'redis' => [
            'host' => '127.0.0.1',
            'port' => 6379
        ],
        'services' => [
            'nginx' => ['port' => 80, 'status_check' => false], // Easypanel manages this
            'php-fpm' => ['port' => 9000, 'status_check' => false],
            'mariadb' => ['port' => 3306, 'status_check' => true],
            'redis' => ['port' => 6379, 'status_check' => true]
        ]
    ];
    
    public function __construct() {
        echo "=== CPS EASYPANEL DEPLOYMENT VALIDATION ===\n";
        echo "Date: " . date('Y-m-d H:i:s') . "\n";
        echo "Environment: Easypanel (Port 3000 + Reverse Proxy)\n";
        echo str_repeat('=', 50) . "\n\n";
    }
    
    public function validate() {
        echo "Starting validation process...\n\n";
        
        // Core validations
        $this->validateInternalConnectivity();
        $this->validateExternalConnectivity();
        $this->validateDatabase();
        $this->validateRedis();
        $this->validateLaravelConfig();
        $this->validateFilePermissions();
        $this->validateIonCube();
        $this->validateLogFiles();
        $this->validateServices();
        
        // Display results
        $this->displayResults();
        
        return [
            'errors' => $this->errors,
            'warnings' => $this->warnings,
            'success' => $this->success,
            'status' => empty($this->errors) ? 'PASS' : 'FAIL'
        ];
    }
    
    private function validateInternalConnectivity() {
        echo "1. VALIDATING INTERNAL CONNECTIVITY (Port 3000)\n";
        echo str_repeat('-', 40) . "\n";
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->config['internal_url']);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, false);
        curl_setopt($ch, CURLOPT_NOBODY, true); // HEAD request only
        
        $result = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);
        
        if ($httpCode == 200 || $httpCode == 301 || $httpCode == 302) {
            echo "✓ Internal connectivity (localhost:3000): SUCCESS\n";
            echo "  HTTP Status: $httpCode\n";
            $this->success[] = "Internal connectivity OK";
        } else {
            echo "✗ Internal connectivity (localhost:3000): FAILED\n";
            echo "  HTTP Status: $httpCode\n";
            echo "  Error: $error\n";
            $this->errors[] = "Internal connectivity failed";
        }
        
        // Check if port is listening
        $this->checkPortListening($this->config['internal_port'], 'Internal Application');
        echo "\n";
    }
    
    private function validateExternalConnectivity() {
        echo "2. VALIDATING EXTERNAL CONNECTIVITY (Reverse Proxy)\n";
        echo str_repeat('-', 40) . "\n";
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->config['app_url']);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, false);
        curl_setopt($ch, CURLOPT_NOBODY, true);
        
        $result = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);
        
        if ($httpCode == 200 || $httpCode == 301 || $httpCode == 302) {
            echo "✓ External connectivity (Reverse Proxy): SUCCESS\n";
            echo "  HTTP Status: $httpCode\n";
            echo "  URL: {$this->config['app_url']}\n";
            $this->success[] = "External connectivity OK";
        } else {
            echo "✗ External connectivity (Reverse Proxy): FAILED\n";
            echo "  HTTP Status: $httpCode\n";
            echo "  Error: $error\n";
            echo "  This may indicate proxy configuration issues\n";
            $this->errors[] = "External connectivity failed - Check proxy configuration";
        }
        echo "\n";
    }
    
    private function validateDatabase() {
        echo "3. VALIDATING DATABASE CONNECTION\n";
        echo str_repeat('-', 40) . "\n";
        
        try {
            $dsn = "mysql:host={$this->config['database']['host']};port={$this->config['database']['port']};dbname={$this->config['database']['database']}";
            $pdo = new PDO($dsn, 'root', '', [
                PDO::ATTR_TIMEOUT => 5,
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
            ]);
            
            echo "✓ Database connection: SUCCESS\n";
            echo "  Host: {$this->config['database']['host']}:{$this->config['database']['port']}\n";
            echo "  Database: {$this->config['database']['database']}\n";
            
            // Test basic queries
            $stmt = $pdo->query("SELECT COUNT(*) as count FROM information_schema.tables WHERE table_schema = '{$this->config['database']['database']}'");
            $tableCount = $stmt->fetch()['count'];
            echo "  Tables found: $tableCount\n";
            
            $this->success[] = "Database connection OK";
            
        } catch (Exception $e) {
            echo "✗ Database connection: FAILED\n";
            echo "  Error: " . $e->getMessage() . "\n";
            echo "  Host: {$this->config['database']['host']}:{$this->config['database']['port']}\n";
            echo "  Database: {$this->config['database']['database']}\n";
            $this->errors[] = "Database connection failed";
        }
        echo "\n";
    }
    
    private function validateRedis() {
        echo "4. VALIDATING REDIS CONNECTION\n";
        echo str_repeat('-', 40) . "\n";
        
        try {
            $redis = new Redis();
            $redis->connect($this->config['redis']['host'], $this->config['redis']['port'], 5);
            
            echo "✓ Redis connection: SUCCESS\n";
            echo "  Host: {$this->config['redis']['host']}:{$this->config['redis']['port']}\n";
            
            // Test Redis functionality
            $testKey = 'cps_validation_test';
            $redis->set($testKey, 'test_value', 60);
            $value = $redis->get($testKey);
            $redis->del($testKey);
            
            if ($value === 'test_value') {
                echo "  Redis operations: OK\n";
            } else {
                echo "  Redis operations: FAILED\n";
                $this->warnings[] = "Redis connection OK but operations failed";
            }
            
            $this->success[] = "Redis connection OK";
            
        } catch (Exception $e) {
            echo "✗ Redis connection: FAILED\n";
            echo "  Error: " . $e->getMessage() . "\n";
            $this->errors[] = "Redis connection failed";
        }
        echo "\n";
    }
    
    private function validateLaravelConfig() {
        echo "5. VALIDATING LARAVEL CONFIGURATION\n";
        echo str_repeat('-', 40) . "\n";
        
        $envFile = __DIR__ . '/../system/.env';
        $configPath = __DIR__ . '/../system/config';
        
        // Check .env file
        if (!file_exists($envFile)) {
            echo "✗ .env file: NOT FOUND\n";
            $this->errors[] = ".env file missing";
        } else {
            echo "✓ .env file: FOUND\n";
            
            $envContent = file_get_contents($envFile);
            
            // Check critical Laravel variables
            $criticalVars = ['APP_KEY', 'DB_CONNECTION', 'DB_HOST', 'DB_DATABASE', 'APP_URL'];
            
            foreach ($criticalVars as $var) {
                if (strpos($envContent, $var . '=') !== false) {
                    echo "  ✓ $var: Configured\n";
                } else {
                    echo "  ✗ $var: MISSING\n";
                    $this->warnings[] = "Missing Laravel variable: $var";
                }
            }
            
            $this->success[] = "Laravel configuration present";
        }
        
        // Check config directory
        if (is_dir($configPath)) {
            echo "✓ Config directory: EXISTS\n";
            
            // Check critical config files
            $configFiles = ['app.php', 'database.php'];
            foreach ($configFiles as $file) {
                $filePath = $configPath . '/' . $file;
                if (file_exists($filePath)) {
                    echo "  ✓ $file: EXISTS\n";
                } else {
                    echo "  ✗ $file: MISSING\n";
                    $this->warnings[] = "Missing config file: $file";
                }
            }
        } else {
            echo "✗ Config directory: NOT FOUND\n";
            $this->errors[] = "Laravel config directory missing";
        }
        
        echo "\n";
    }
    
    private function validateFilePermissions() {
        echo "6. VALIDATING FILE PERMISSIONS\n";
        echo str_repeat('-', 40) . "\n";
        
        $pathsToCheck = [
            __DIR__ . '/../system/storage' => 'Storage directory',
            __DIR__ . '/../system/storage/app' => 'Storage app directory',
            __DIR__ . '/../system/storage/framework' => 'Storage framework directory',
            __DIR__ . '/../system/storage/logs' => 'Storage logs directory',
            __DIR__ . '/../system/bootstrap/cache' => 'Bootstrap cache directory'
        ];
        
        foreach ($pathsToCheck as $path => $description) {
            if (!is_dir($path)) {
                echo "✗ $description: NOT FOUND\n";
                $this->errors[] = "$description missing";
                continue;
            }
            
            if (is_writable($path)) {
                echo "✓ $description: WRITABLE\n";
            } else {
                echo "✗ $description: NOT WRITABLE\n";
                $this->errors[] = "$description not writable";
            }
        }
        
        echo "\n";
    }
    
    private function validateIonCube() {
        echo "7. VALIDATING IONCUBE LOADER\n";
        echo str_repeat('-', 40) . "\n";
        
        if (extension_loaded('ionCube Loader')) {
            echo "✓ ionCube Loader: LOADED\n";
            $version = ioncube_loader_version();
            echo "  Version: $version\n";
            $this->success[] = "ionCube Loader loaded";
        } else {
            echo "✗ ionCube Loader: NOT LOADED\n";
            echo "  This is required for encrypted CPS code\n";
            $this->errors[] = "ionCube Loader not loaded";
        }
        echo "\n";
    }
    
    private function validateLogFiles() {
        echo "8. VALIDATING LOG FILES\n";
        echo str_repeat('-', 40) . "\n";
        
        $logPaths = [
            __DIR__ . '/../system/storage/logs/laravel.log' => 'Laravel application log',
            __DIR__ . '/../system/storage/logs' => 'Logs directory'
        ];
        
        foreach ($logPaths as $path => $description) {
            if (is_dir($path)) {
                echo "✓ $description: EXISTS\n";
                
                // Check if log directory is writable
                if (is_writable($path)) {
                    echo "  ✓ Log directory: WRITABLE\n";
                } else {
                    echo "  ✗ Log directory: NOT WRITABLE\n";
                    $this->warnings[] = "$description not writable";
                }
                
            } else {
                echo "✗ $description: NOT FOUND\n";
                $this->warnings[] = "$description missing";
            }
        }
        echo "\n";
    }
    
    private function validateServices() {
        echo "9. VALIDATING SYSTEM SERVICES\n";
        echo str_repeat('-', 40) . "\n";
        
        // Note: In Easypanel, some services are managed differently
        foreach ($this->config['services'] as $service => $config) {
            if ($config['status_check']) {
                $this->checkService($service, $config['port']);
            } else {
                echo "○ $service: Managed by Easypanel (no direct check)\n";
            }
        }
        echo "\n";
    }
    
    private function checkPortListening($port, $service) {
        $command = "netstat -tuln 2>/dev/null | grep :$port || ss -tuln 2>/dev/null | grep :$port";
        exec($command, $output, $returnCode);
        
        if (!empty($output)) {
            echo "✓ $service port $port: LISTENING\n";
            foreach ($output as $line) {
                echo "  $line\n";
            }
        } else {
            echo "✗ $service port $port: NOT LISTENING\n";
            $this->warnings[] = "$service port $port not listening";
        }
    }
    
    private function checkService($service, $port) {
        $this->checkPortListening($port, $service);
    }
    
    private function displayResults() {
        echo "\n";
        echo str_repeat('=', 50) . "\n";
        echo "VALIDATION RESULTS SUMMARY\n";
        echo str_repeat('=', 50) . "\n";
        
        echo "✓ SUCCESS (" . count($this->success) . "):\n";
        foreach ($this->success as $item) {
            echo "  • $item\n";
        }
        
        if (!empty($this->warnings)) {
            echo "\n⚠ WARNINGS (" . count($this->warnings) . "):\n";
            foreach ($this->warnings as $item) {
                echo "  • $item\n";
            }
        }
        
        if (!empty($this->errors)) {
            echo "\n✗ ERRORS (" . count($this->errors) . "):\n";
            foreach ($this->errors as $item) {
                echo "  • $item\n";
            }
        }
        
        $status = empty($this->errors) ? 'PASS' : 'FAIL';
        echo "\n";
        echo str_repeat('=', 50) . "\n";
        echo "OVERALL STATUS: $status\n";
        
        if ($status === 'FAIL') {
            echo "\nRECOMMENDED ACTIONS:\n";
            echo "1. Check Easypanel application configuration\n";
            echo "2. Verify port 3000 is correctly configured\n";
            echo "3. Check reverse proxy settings\n";
            echo "4. Verify database and Redis connections\n";
            echo "5. Ensure ionCube Loader is installed\n";
        }
        
        echo str_repeat('=', 50) . "\n";
    }
}

// Execute validation if run directly
if (basename(__FILE__) == basename($_SERVER['PHP_SELF'])) {
    $validator = new CPSEasypanelValidator();
    $results = $validator->validate();
    
    // Log results for auto-monitoring
    $logFile = __DIR__ . '/validation_results_' . date('Y-m-d_H-i-s') . '.log';
    file_put_contents($logFile, json_encode($results, JSON_PRETTY_PRINT));
    
    exit($results['status'] === 'PASS' ? 0 : 1);
}
?>