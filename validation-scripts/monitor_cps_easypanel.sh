#!/bin/bash

# CPS Continuous Monitoring Script for Easypanel
# Monitors the CPS system and logs results for post-deploy analysis

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/monitoring"
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
MONITOR_LOG="$LOG_DIR/monitor_$TIMESTAMP.log"
APP_URL="https://cps.qhosting.net"
INTERNAL_URL="http://localhost:3000"
INTERVAL=30  # Check every 30 seconds
MAX_LOG_SIZE=10485760  # 10MB max log size

# Create monitoring directory
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$MONITOR_LOG"
}

# Function to check log size and rotate if necessary
check_log_size() {
    if [[ -f "$MONITOR_LOG" ]]; then
        LOG_SIZE=$(stat -f%z "$MONITOR_LOG" 2>/dev/null || stat -c%s "$MONITOR_LOG" 2>/dev/null || echo 0)
        if [[ $LOG_SIZE -gt $MAX_LOG_SIZE ]]; then
            mv "$MONITOR_LOG" "${MONITOR_LOG%.log}_$(date +%H%M%S).log"
            log_message "Log file rotated due to size limit"
        fi
    fi
}

# Function to perform health check
health_check() {
    local check_name="$1"
    local url="$2"
    local timeout="${3:-10}"
    local expected_codes="${4:-200|301|302}"
    
    log_message "Checking $check_name..."
    
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
        --connect-timeout 5 \
        --max-time "$timeout" \
        --location \
        "$url" 2>/dev/null || echo "000")
    
    if [[ "$HTTP_CODE" =~ ^($expected_codes)$ ]]; then
        log_message "  ✓ $check_name: OK (HTTP $HTTP_CODE)"
        return 0
    else
        log_message "  ✗ $check_name: FAILED (HTTP $HTTP_CODE)"
        return 1
    fi
}

# Function to check service ports
check_port() {
    local service_name="$1"
    local port="$2"
    
    log_message "Checking $service_name port $port..."
    
    if netstat -tuln 2>/dev/null | grep -q ":$port" || ss -tuln 2>/dev/null | grep -q ":$port"; then
        log_message "  ✓ $service_name port $port: LISTENING"
        return 0
    else
        log_message "  ✗ $service_name port $port: NOT LISTENING"
        return 1
    fi
}

# Function to check database connectivity
check_database() {
    log_message "Checking database connectivity..."
    
    if mysql -h 127.0.0.1 -P 3306 -u root -e "SELECT 1" >/dev/null 2>&1; then
        log_message "  ✓ Database: CONNECTED"
        
        # Check CPS database
        if mysql -h 127.0.0.1 -P 3306 -u root cps_database -e "SHOW TABLES" >/dev/null 2>&1; then
            log_message "  ✓ CPS Database: ACCESSIBLE"
            return 0
        else
            log_message "  ✗ CPS Database: NOT ACCESSIBLE"
            return 1
        fi
    else
        log_message "  ✗ Database: CONNECTION FAILED"
        return 1
    fi
}

# Function to check Redis connectivity
check_redis() {
    log_message "Checking Redis connectivity..."
    
    if redis-cli -h 127.0.0.1 -p 6379 ping >/dev/null 2>&1; then
        log_message "  ✓ Redis: CONNECTED"
        return 0
    else
        log_message "  ✗ Redis: CONNECTION FAILED"
        return 1
    fi
}

# Function to check Laravel application health
check_laravel_health() {
    log_message "Checking Laravel application health..."
    
    # Check key files
    local app_path="/workspace/system"
    local issues=0
    
    # Check .env file
    if [[ -f "$app_path/.env" ]]; then
        log_message "  ✓ .env file: EXISTS"
    else
        log_message "  ✗ .env file: MISSING"
        ((issues++))
    fi
    
    # Check storage permissions
    if [[ -d "$app_path/storage" ]] && [[ -w "$app_path/storage" ]]; then
        log_message "  ✓ storage directory: WRITABLE"
    else
        log_message "  ✗ storage directory: NOT WRITABLE"
        ((issues++))
    fi
    
    # Check artisan
    if [[ -f "$app_path/artisan" ]]; then
        log_message "  ✓ artisan file: EXISTS"
    else
        log_message "  ✗ artisan file: MISSING"
        ((issues++))
    fi
    
    # Check recent errors in log
    if [[ -f "$app_path/storage/logs/laravel.log" ]]; then
        local error_count=$(tail -100 "$app_path/storage/logs/laravel.log" 2>/dev/null | grep -i error | wc -l)
        if [[ $error_count -gt 0 ]]; then
            log_message "  ⚠ Recent errors in log: $error_count"
        else
            log_message "  ✓ No recent errors in log"
        fi
    else
        log_message "  ✗ Laravel log: NOT FOUND"
        ((issues++))
    fi
    
    return $issues
}

# Function to perform comprehensive system check
system_check() {
    local check_type="${1:-full}"
    
    log_message ""
    log_message "=== SYSTEM CHECK STARTED ($check_type) ==="
    
    local errors=0
    local warnings=0
    
    # Always check critical services
    check_port "Application" 3000 || ((errors++))
    health_check "Internal Application" "$INTERNAL_URL" 10 "200|301|302" || ((errors++))
    
    if [[ "$check_type" == "full" ]]; then
        # Full check includes external connectivity and services
        health_check "External Application" "$APP_URL" 15 "200|301|302" || ((warnings++))
        check_database || ((warnings++))
        check_redis || ((warnings++))
        check_laravel_health || ((warnings++))
    fi
    
    log_message ""
    log_message "=== SYSTEM CHECK COMPLETED ==="
    log_message "Errors: $errors, Warnings: $warnings"
    
    if [[ $errors -gt 0 ]]; then
        log_message "⚠ CRITICAL ISSUES DETECTED"
    elif [[ $warnings -gt 0 ]]; then
        log_message "⚠ WARNINGS DETECTED"
    else
        log_message "✓ ALL CHECKS PASSED"
    fi
    
    return $errors
}

# Function to handle alerts
send_alert() {
    local severity="$1"
    local message="$2"
    
    log_message "ALERT [$severity]: $message"
    
    # You can add email/SMS integration here
    # Example: send_email "admin@example.com" "CPS Alert: $message"
}

# Function to display usage
usage() {
    echo "CPS Continuous Monitoring Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help          Show this help message"
    echo "  -i, --interval SEC  Set check interval (default: 30 seconds)"
    echo "  -t, --type TYPE     Check type: 'full' or 'quick' (default: full)"
    echo "  -d, --daemon        Run as daemon (continuous monitoring)"
    echo "  --once              Run single check and exit"
    echo ""
    echo "Examples:"
    echo "  $0 --once                    # Run single comprehensive check"
    echo "  $0 --interval 60 --daemon    # Run daemon with 60-second intervals"
    echo "  $0 --type quick --once       # Run quick check and exit"
}

# Parse command line arguments
CHECK_TYPE="full"
RUN_ONCE=false
DAEMON_MODE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -i|--interval)
            INTERVAL="$2"
            shift 2
            ;;
        -t|--type)
            CHECK_TYPE="$2"
            shift 2
            ;;
        -d|--daemon)
            DAEMON_MODE=true
            shift
            ;;
        --once)
            RUN_ONCE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Main monitoring loop
main() {
    log_message "CPS Monitoring Script Started"
    log_message "Mode: $(if $DAEMON_MODE; then echo "Daemon"; elif $RUN_ONCE; then echo "Single Run"; else echo "Interactive"; fi)"
    log_message "Check Type: $CHECK_TYPE"
    log_message "Interval: $INTERVAL seconds"
    log_message "Log File: $MONITOR_LOG"
    
    if $RUN_ONCE; then
        system_check "$CHECK_TYPE"
        log_message "Single check completed"
        return $?
    fi
    
    while true; do
        check_log_size
        system_check "$CHECK_TYPE"
        
        if $DAEMON_MODE; then
            log_message "Sleeping for $INTERVAL seconds..."
            sleep "$INTERVAL"
        else
            log_message "Check completed. Press Ctrl+C to exit or run again."
            sleep "$INTERVAL"
        fi
    done
}

# Trap signals for clean shutdown
trap 'log_message "Monitoring script terminated"; exit 0' SIGINT SIGTERM

# Run main function
main