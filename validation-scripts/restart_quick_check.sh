#!/bin/bash

################################################################################
# CPS Restart Diagnostic Script for Easypanel
# Version: 1.0
# Author: MiniMax Agent
# Purpose: Quick diagnostic after service restart with console output
################################################################################

# Quick system check for console visibility
echo "================================================================================"
echo " CPS POST-RESTART QUICK DIAGNOSTIC - Easypanel Console"
echo "================================================================================"
echo "Timestamp: $(date)"
echo ""

# Critical checks only (for console readability)
echo "🔍 Checking critical system components..."

# Port 3000 check
if netstat -tlnp 2>/dev/null | grep -q ":3000 "; then
    echo "✅ Puerto 3000: LISTENING"
else
    echo "❌ Puerto 3000: NOT LISTENING - CRITICAL"
fi

# PHP-FPM check
if pgrep -f "php-fpm" >/dev/null; then
    echo "✅ PHP-FPM: RUNNING"
else
    echo "❌ PHP-FPM: NOT RUNNING - CRITICAL"
fi

# Internal connectivity
if curl -s -m 3 http://localhost:3000 >/dev/null 2>&1; then
    echo "✅ App Response: OK (localhost:3000)"
else
    echo "⚠️ App Response: FAILING (localhost:3000)"
fi

# Database check
if mysql -u cps_user -pcps_password123 -e "SELECT 1;" >/dev/null 2>&1; then
    echo "✅ Database: CONNECTED"
else
    echo "❌ Database: CONNECTION FAILED"
fi

# External access test
if curl -s -m 5 https://cps.qhosting.net >/dev/null 2>&1; then
    echo "✅ External Access: OK (https://cps.qhosting.net)"
else
    echo "⚠️ External Access: FAILING (https://cps.qhosting.net)"
fi

echo ""
echo "For detailed diagnostic, run: bash validation-scripts/easypanel_post_deploy_check.sh"
echo "================================================================================"