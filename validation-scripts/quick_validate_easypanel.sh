#!/bin/bash

# Quick CPS Validation Script for Easypanel
# This script provides fast diagnostics for CPS deployment issues

echo "=== CPS EASYPANEL QUICK VALIDATION ==="
echo "Date: $(date)"
echo "Environment: Easypanel (Port 3000 + Reverse Proxy)"
echo "================================================"

# Configuration
APP_URL="https://cps.qhosting.net"
INTERNAL_URL="http://localhost:3000"
INTERNAL_PORT=3000

echo ""
echo "1. CHECKING INTERNAL CONNECTIVITY (Port 3000)"
echo "------------------------------------------------"

# Check if port 3000 is listening
if netstat -tuln 2>/dev/null | grep -q ":3000" || ss -tuln 2>/dev/null | grep -q ":3000"; then
    echo "✓ Port 3000: LISTENING"
    netstat -tuln 2>/dev/null | grep ":3000" || ss -tuln 2>/dev/null | grep ":3000"
else
    echo "✗ Port 3000: NOT LISTENING"
fi

# Test internal connectivity
echo ""
echo "Testing internal connectivity..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 10 "$INTERNAL_URL" 2>/dev/null || echo "000")

if [[ "$HTTP_CODE" =~ ^(200|301|302)$ ]]; then
    echo "✓ Internal HTTP: OK (Status: $HTTP_CODE)"
else
    echo "✗ Internal HTTP: FAILED (Status: $HTTP_CODE)"
fi

echo ""
echo "2. CHECKING EXTERNAL CONNECTIVITY (Reverse Proxy)"
echo "--------------------------------------------------"

# Test external connectivity
echo "Testing external connectivity..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 10 --max-time 15 "$APP_URL" 2>/dev/null || echo "000")

if [[ "$HTTP_CODE" =~ ^(200|301|302)$ ]]; then
    echo "✓ External HTTP: OK (Status: $HTTP_CODE)"
    echo "  URL: $APP_URL"
else
    echo "✗ External HTTP: FAILED (Status: $HTTP_CODE)"
    echo "  URL: $APP_URL"
    echo "  → Check Easypanel reverse proxy configuration"
fi

echo ""
echo "3. CHECKING DATABASE CONNECTION"
echo "--------------------------------"

# Test MySQL connection
if command -v mysql >/dev/null 2>&1; then
    if mysql -h 127.0.0.1 -P 3306 -u root -e "SELECT 1" >/dev/null 2>&1; then
        echo "✓ MySQL: CONNECTED"
        echo "  Host: 127.0.0.1:3306"
    else
        echo "✗ MySQL: CONNECTION FAILED"
    fi
else
    echo "○ MySQL client: NOT AVAILABLE"
fi

echo ""
echo "4. CHECKING REDIS CONNECTION"
echo "-----------------------------"

# Test Redis connection
if command -v redis-cli >/dev/null 2>&1; then
    if redis-cli -h 127.0.0.1 -p 6379 ping >/dev/null 2>&1; then
        echo "✓ Redis: CONNECTED"
        echo "  Host: 127.0.0.1:6379"
    else
        echo "✗ Redis: CONNECTION FAILED"
    fi
else
    echo "○ Redis client: NOT AVAILABLE"
fi

echo ""
echo "5. CHECKING LARAVEL FILES"
echo "--------------------------"

# Check Laravel directory structure
if [[ -d "/workspace/system" ]]; then
    echo "✓ Laravel directory: EXISTS"
    
    # Check critical files
    if [[ -f "/workspace/system/.env" ]]; then
        echo "  ✓ .env file: EXISTS"
    else
        echo "  ✗ .env file: MISSING"
    fi
    
    if [[ -d "/workspace/system/storage" ]]; then
        echo "  ✓ storage directory: EXISTS"
        
        # Check permissions
        if [[ -w "/workspace/system/storage" ]]; then
            echo "    ✓ storage writable: YES"
        else
            echo "    ✗ storage writable: NO"
        fi
    else
        echo "  ✗ storage directory: MISSING"
    fi
    
    if [[ -f "/workspace/system/artisan" ]]; then
        echo "  ✓ artisan file: EXISTS"
    else
        echo "  ✗ artisan file: MISSING"
    fi
else
    echo "✗ Laravel directory: NOT FOUND"
fi

echo ""
echo "6. CHECKING PHP CONFIGURATION"
echo "------------------------------"

# Check PHP version
if command -v php >/dev/null 2>&1; then
    PHP_VERSION=$(php -v | head -n1 | cut -d' ' -f2)
    echo "✓ PHP Version: $PHP_VERSION"
    
    # Check ionCube
    if php -m | grep -q "ionCube Loader"; then
        echo "  ✓ ionCube Loader: LOADED"
    else
        echo "  ✗ ionCube Loader: NOT LOADED"
    fi
else
    echo "✗ PHP: NOT AVAILABLE"
fi

echo ""
echo "7. CHECKING LOGS"
echo "----------------"

# Check Laravel log
if [[ -f "/workspace/system/storage/logs/laravel.log" ]]; then
    echo "✓ Laravel log: EXISTS"
    
    # Show last 5 errors if any
    ERROR_COUNT=$(tail -50 /workspace/system/storage/logs/laravel.log 2>/dev/null | grep -i error | wc -l)
    if [[ $ERROR_COUNT -gt 0 ]]; then
        echo "  ⚠ Recent errors found: $ERROR_COUNT"
        echo "  Last errors:"
        tail -5 /workspace/system/storage/logs/laravel.log 2>/dev/null | grep -i error | head -3
    else
        echo "  ✓ No recent errors in log"
    fi
else
    echo "✗ Laravel log: NOT FOUND"
fi

echo ""
echo "================================================"
echo "QUICK VALIDATION SUMMARY"
echo "================================================"

# Determine overall status
ERRORS=0
WARNINGS=0

# Count issues based on our checks
! netstat -tuln 2>/dev/null | grep -q ":3000" && ! ss -tuln 2>/dev/null | grep -q ":3000" && ((ERRORS++))
curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 10 "$INTERNAL_URL" 2>/dev/null | grep -q -v "200\|301\|302" && ((ERRORS++))
curl -s -o /dev/null -w "%{http_code}" --connect-timeout 10 --max-time 15 "$APP_URL" 2>/dev/null | grep -q -v "200\|301\|302" && ((WARNINGS++))

if ! mysql -h 127.0.0.1 -P 3306 -u root -e "SELECT 1" >/dev/null 2>&1; then
    ((WARNINGS++))
fi

if ! redis-cli -h 127.0.0.1 -p 6379 ping >/dev/null 2>&1; then
    ((WARNINGS++))
fi

if [[ ! -d "/workspace/system" ]]; then
    ((ERRORS++))
fi

if ! php -m | grep -q "ionCube Loader"; then
    ((WARNINGS++))
fi

echo "Status: $(if [[ $ERRORS -eq 0 ]]; then echo 'PASS ✓'; else echo "FAIL ✗ ($ERRORS errors, $WARNINGS warnings)"; fi)"

if [[ $ERRORS -gt 0 ]]; then
    echo ""
    echo "CRITICAL ISSUES DETECTED:"
    echo "• Port 3000 not listening or application not responding"
    echo "• Laravel files missing or corrupted"
    echo ""
    echo "RECOMMENDED ACTIONS:"
    echo "1. Check Easypanel application status"
    echo "2. Verify port 3000 configuration"
    echo "3. Restart the application container"
    echo "4. Check application logs for startup errors"
fi

if [[ $WARNINGS -gt 0 ]] && [[ $ERRORS -eq 0 ]]; then
    echo ""
    echo "WARNINGS DETECTED:"
    echo "• External connectivity issues (check reverse proxy)"
    echo "• Database or Redis connectivity issues"
    echo "• ionCube Loader not loaded"
    echo ""
    echo "RECOMMENDED ACTIONS:"
    echo "1. Check Easypanel reverse proxy settings"
    echo "2. Verify database and Redis services"
    echo "3. Install ionCube Loader extension"
fi

echo ""
echo "For detailed validation, run: php validate_deployment_easypanel.php"
echo "================================================"

# Log results
LOG_FILE="/workspace/validation-scripts/quick_validation_$(date +%Y-%m-%d_%H-%M-%S).log"
{
    echo "Quick Validation Results - $(date)"
    echo "Errors: $ERRORS"
    echo "Warnings: $WARNINGS"
    echo "Internal URL: $INTERNAL_URL"
    echo "External URL: $APP_URL"
    echo "Port 3000 Status: $(netstat -tuln 2>/dev/null | grep -q ':3000' || echo 'NOT LISTENING')"
} > "$LOG_FILE"

echo "Results logged to: $LOG_FILE"