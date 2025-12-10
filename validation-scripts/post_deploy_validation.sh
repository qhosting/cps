#!/bin/bash

# CPS Auto-Validation Script for Post-Deploy Monitoring
# This script runs automatically after deployment and logs results

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/logs"
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
LOG_FILE="$LOG_DIR/deploy_validation_$TIMESTAMP.log"

# Create logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Function to log section headers
log_section() {
    echo "" | tee -a "$LOG_FILE"
    echo "=== $1 ===" | tee -a "$LOG_FILE"
    echo "$(date)" | tee -a "$LOG_FILE"
    echo "================================================" | tee -a "$LOG_FILE"
}

# Initialize log
log_message "Starting CPS Post-Deploy Validation"
log_section "SYSTEM INFORMATION"

# Log system information
log_message "Host: $(hostname)"
log_message "User: $(whoami)"
log_message "Working Directory: $(pwd)"
log_message "Available Memory: $(free -h | grep Mem | awk '{print $7}')"
log_message "Available Disk: $(df -h / | tail -1 | awk '{print $4}')"

log_section "EASYPANEL VALIDATION"

# 1. Check internal connectivity (Port 3000)
log_message "Checking internal connectivity (Port 3000)..."
INTERNAL_URL="http://localhost:3000"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 10 "$INTERNAL_URL" 2>/dev/null || echo "000")

if [[ "$HTTP_CODE" =~ ^(200|301|302)$ ]]; then
    log_message "✓ Internal connectivity: OK (HTTP $HTTP_CODE)"
    INTERNAL_STATUS="OK"
else
    log_message "✗ Internal connectivity: FAILED (HTTP $HTTP_CODE)"
    INTERNAL_STATUS="FAILED"
fi

# 2. Check port 3000 listening
log_message "Checking if port 3000 is listening..."
if netstat -tuln 2>/dev/null | grep -q ":3000" || ss -tuln 2>/dev/null | grep -q ":3000"; then
    log_message "✓ Port 3000: LISTENING"
    PORT_STATUS="LISTENING"
else
    log_message "✗ Port 3000: NOT LISTENING"
    PORT_STATUS="NOT LISTENING"
fi

# 3. Check external connectivity (Reverse Proxy)
log_message "Checking external connectivity (Reverse Proxy)..."
APP_URL="https://cps.qhosting.net"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 10 --max-time 15 "$APP_URL" 2>/dev/null || echo "000")

if [[ "$HTTP_CODE" =~ ^(200|301|302)$ ]]; then
    log_message "✓ External connectivity: OK (HTTP $HTTP_CODE)"
    EXTERNAL_STATUS="OK"
else
    log_message "✗ External connectivity: FAILED (HTTP $HTTP_CODE)"
    EXTERNAL_STATUS="FAILED"
    log_message "→ This may indicate reverse proxy configuration issues"
fi

log_section "DATABASE VALIDATION"

# 4. Check MySQL connection
log_message "Checking MySQL connection..."
if command -v mysql >/dev/null 2>&1; then
    if mysql -h 127.0.0.1 -P 3306 -u root -e "SELECT 1" >/dev/null 2>&1; then
        log_message "✓ MySQL: CONNECTED"
        
        # Try to connect to CPS database
        if mysql -h 127.0.0.1 -P 3306 -u root cps_database -e "SHOW TABLES" >/dev/null 2>&1; then
            log_message "✓ CPS Database: ACCESSIBLE"
            TABLE_COUNT=$(mysql -h 127.0.0.1 -P 3306 -u root cps_database -e "SHOW TABLES" 2>/dev/null | wc -l)
            log_message "  Tables found: $((TABLE_COUNT - 1))"
        else
            log_message "✗ CPS Database: NOT ACCESSIBLE"
        fi
        DB_STATUS="OK"
    else
        log_message "✗ MySQL: CONNECTION FAILED"
        DB_STATUS="FAILED"
    fi
else
    log_message "○ MySQL client: NOT AVAILABLE"
    DB_STATUS="UNKNOWN"
fi

log_section "REDIS VALIDATION"

# 5. Check Redis connection
log_message "Checking Redis connection..."
if command -v redis-cli >/dev/null 2>&1; then
    if redis-cli -h 127.0.0.1 -p 6379 ping >/dev/null 2>&1; then
        log_message "✓ Redis: CONNECTED"
        REDIS_STATUS="OK"
    else
        log_message "✗ Redis: CONNECTION FAILED"
        REDIS_STATUS="FAILED"
    fi
else
    log_message "○ Redis client: NOT AVAILABLE"
    REDIS_STATUS="UNKNOWN"
fi

log_section "LARAVEL CONFIGURATION VALIDATION"

# 6. Check Laravel directory structure
log_message "Checking Laravel configuration..."
LARAVEL_PATH="/workspace/system"

if [[ -d "$LARAVEL_PATH" ]]; then
    log_message "✓ Laravel directory: EXISTS"
    
    # Check .env file
    if [[ -f "$LARAVEL_PATH/.env" ]]; then
        log_message "✓ .env file: EXISTS"
        
        # Check critical Laravel variables
        if grep -q "APP_KEY=" "$LARAVEL_PATH/.env"; then
            log_message "  ✓ APP_KEY: CONFIGURED"
        else
            log_message "  ✗ APP_KEY: MISSING"
        fi
        
        if grep -q "DB_HOST=" "$LARAVEL_PATH/.env"; then
            log_message "  ✓ Database config: CONFIGURED"
        else
            log_message "  ✗ Database config: MISSING"
        fi
    else
        log_message "✗ .env file: MISSING"
    fi
    
    # Check storage permissions
    if [[ -d "$LARAVEL_PATH/storage" ]]; then
        log_message "✓ storage directory: EXISTS"
        
        if [[ -w "$LARAVEL_PATH/storage" ]]; then
            log_message "  ✓ storage writable: YES"
        else
            log_message "  ✗ storage writable: NO"
        fi
    else
        log_message "✗ storage directory: MISSING"
    fi
    
    # Check artisan
    if [[ -f "$LARAVEL_PATH/artisan" ]]; then
        log_message "✓ artisan file: EXISTS"
    else
        log_message "✗ artisan file: MISSING"
    fi
    
    LARAVEL_STATUS="OK"
else
    log_message "✗ Laravel directory: NOT FOUND"
    LARAVEL_STATUS="FAILED"
fi

log_section "PHP CONFIGURATION VALIDATION"

# 7. Check PHP and ionCube
log_message "Checking PHP configuration..."
if command -v php >/dev/null 2>&1; then
    PHP_VERSION=$(php -v | head -n1 | cut -d' ' -f2)
    log_message "✓ PHP Version: $PHP_VERSION"
    
    # Check ionCube
    if php -m | grep -q "ionCube Loader"; then
        IONCUBE_VERSION=$(php -m | grep "ionCube Loader" | head -1)
        log_message "✓ ionCube Loader: LOADED ($IONCUBE_VERSION)"
        IONCUBE_STATUS="OK"
    else
        log_message "✗ ionCube Loader: NOT LOADED"
        log_message "  → This is required for encrypted CPS code"
        IONCUBE_STATUS="FAILED"
    fi
    
    PHP_STATUS="OK"
else
    log_message "✗ PHP: NOT AVAILABLE"
    PHP_STATUS="FAILED"
fi

log_section "LOG ANALYSIS"

# 8. Check Laravel logs
log_message "Checking Laravel logs..."
if [[ -f "$LARAVEL_PATH/storage/logs/laravel.log" ]]; then
    log_message "✓ Laravel log: EXISTS"
    
    # Count recent errors
    ERROR_COUNT=$(tail -100 "$LARAVEL_PATH/storage/logs/laravel.log" 2>/dev/null | grep -i error | wc -l)
    if [[ $ERROR_COUNT -gt 0 ]]; then
        log_message "⚠ Recent errors in log: $ERROR_COUNT"
        log_message "  Last 3 errors:"
        tail -20 "$LARAVEL_PATH/storage/logs/laravel.log" 2>/dev/null | grep -i error | tail -3 | while read -r line; do
            log_message "    $line"
        done
    else
        log_message "✓ No recent errors in Laravel log"
    fi
    
    # Log file size
    LOG_SIZE=$(du -h "$LARAVEL_PATH/storage/logs/laravel.log" | cut -f1)
    log_message "  Log file size: $LOG_SIZE"
    
    LOG_STATUS="OK"
else
    log_message "✗ Laravel log: NOT FOUND"
    LOG_STATUS="FAILED"
fi

log_section "SERVICE STATUS"

# 9. Check running services
log_message "Checking system services..."
for service in nginx php-fpm mariadb redis; do
    if systemctl is-active --quiet "$service" 2>/dev/null; then
        log_message "✓ $service: RUNNING"
    else
        log_message "○ $service: $(systemctl is-active "$service" 2>/dev/null || echo 'UNKNOWN')"
    fi
done

log_section "VALIDATION SUMMARY"

# Calculate overall status
ERRORS=0
WARNINGS=0

# Count issues
[[ "$INTERNAL_STATUS" == "FAILED" ]] && ((ERRORS++))
[[ "$PORT_STATUS" != "LISTENING" ]] && ((ERRORS++))
[[ "$DB_STATUS" == "FAILED" ]] && ((WARNINGS++))
[[ "$REDIS_STATUS" == "FAILED" ]] && ((WARNINGS++))
[[ "$LARAVEL_STATUS" == "FAILED" ]] && ((ERRORS++))
[[ "$IONCUBE_STATUS" == "FAILED" ]] && ((WARNINGS++))
[[ "$EXTERNAL_STATUS" == "FAILED" ]] && ((WARNINGS++))

# Overall status
if [[ $ERRORS -eq 0 ]]; then
    OVERALL_STATUS="PASS ✓"
    log_message "OVERALL STATUS: PASS ✓"
else
    OVERALL_STATUS="FAIL ✗"
    log_message "OVERALL STATUS: FAIL ✗ ($ERRORS errors, $WARNINGS warnings)"
fi

# Log detailed results
log_message "DETAILED RESULTS:"
log_message "  Internal Connectivity: $INTERNAL_STATUS"
log_message "  Port 3000 Status: $PORT_STATUS"
log_message "  External Connectivity: $EXTERNAL_STATUS"
log_message "  Database Status: $DB_STATUS"
log_message "  Redis Status: $REDIS_STATUS"
log_message "  Laravel Config: $LARAVEL_STATUS"
log_message "  PHP/ionCube: $PHP_STATUS"
log_message "  Log Status: $LOG_STATUS"

# Provide recommendations
if [[ $ERRORS -gt 0 ]]; then
    log_message ""
    log_message "CRITICAL ISSUES REQUIRING IMMEDIATE ATTENTION:"
    
    [[ "$INTERNAL_STATUS" == "FAILED" ]] && log_message "  • Internal application not responding on port 3000"
    [[ "$PORT_STATUS" != "LISTENING" ]] && log_message "  • Application port 3000 not listening"
    [[ "$LARAVEL_STATUS" == "FAILED" ]] && log_message "  • Laravel application files missing or corrupted"
    
    log_message ""
    log_message "RECOMMENDED ACTIONS:"
    log_message "  1. Check Easypanel application container status"
    log_message "  2. Verify application startup logs"
    log_message "  3. Restart the application if necessary"
    log_message "  4. Check port 3000 configuration in Easypanel"
fi

if [[ $WARNINGS -gt 0 ]] && [[ $ERRORS -eq 0 ]]; then
    log_message ""
    log_message "WARNINGS (Non-critical but should be addressed):"
    
    [[ "$EXTERNAL_STATUS" == "FAILED" ]] && log_message "  • External access via reverse proxy not working"
    [[ "$DB_STATUS" == "FAILED" ]] && log_message "  • Database connectivity issues"
    [[ "$REDIS_STATUS" == "FAILED" ]] && log_message "  • Redis connectivity issues"
    [[ "$IONCUBE_STATUS" == "FAILED" ]] && log_message "  • ionCube Loader not installed (required for CPS)"
    
    log_message ""
    log_message "RECOMMENDED ACTIONS:"
    log_message "  1. Check Easypanel reverse proxy configuration"
    log_message "  2. Verify database and Redis service status"
    log_message "  3. Install ionCube Loader PHP extension"
fi

# Create summary file for easy monitoring
SUMMARY_FILE="$LOG_DIR/latest_status.txt"
{
    echo "CPS Deployment Status - $(date)"
    echo "Overall Status: $OVERALL_STATUS"
    echo "Errors: $ERRORS"
    echo "Warnings: $WARNINGS"
    echo ""
    echo "Component Status:"
    echo "  Internal: $INTERNAL_STATUS"
    echo "  Port 3000: $PORT_STATUS"
    echo "  External: $EXTERNAL_STATUS"
    echo "  Database: $DB_STATUS"
    echo "  Redis: $REDIS_STATUS"
    echo "  Laravel: $LARAVEL_STATUS"
    echo "  PHP/ionCube: $PHP_STATUS"
    echo "  Logs: $LOG_STATUS"
    echo ""
    echo "Log file: $LOG_FILE"
} > "$SUMMARY_FILE"

log_message ""
log_message "Validation completed successfully"
log_message "Detailed log: $LOG_FILE"
log_message "Summary file: $SUMMARY_FILE"

# Exit with appropriate code
if [[ $ERRORS -eq 0 ]]; then
    exit 0
else
    exit 1
fi