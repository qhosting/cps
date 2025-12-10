#!/bin/bash

################################################################################
# CPS Auto-Diagnostic Master Script for Easypanel
# Version: 1.0
# Author: MiniMax Agent
# Purpose: Master script to handle all diagnostic scenarios automatically
################################################################################

SCRIPT_DIR="/workspace/validation-scripts"
source "$SCRIPT_DIR/validation.conf" 2>/dev/null || {
    echo "Warning: validation.conf not found, using defaults"
    AUTO_VALIDATE_ON_DEPLOY=true
    AUTO_VALIDATE_ON_RESTART=true
    CONSOLE_OUTPUT=true
}

# Determine execution context
CONTEXT="${1:-unknown}"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')

log_message() {
    if [ "$CONSOLE_OUTPUT" = "true" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    fi
}

case "$CONTEXT" in
    "deploy")
        log_message "🚀 DEPLOY context detected - Running comprehensive validation"
        if [ "$AUTO_VALIDATE_ON_DEPLOY" = "true" ]; then
            cd "$SCRIPT_DIR"
            bash "$DEPLOY_SCRIPT"
            cd - >/dev/null
        fi
        ;;
    
    "restart")
        log_message "🔄 RESTART context detected - Running quick validation"
        if [ "$AUTO_VALIDATE_ON_RESTART" = "true" ]; then
            cd "$SCRIPT_DIR"
            bash "$RESTART_SCRIPT"
            cd - >/dev/null
        fi
        ;;
    
    "manual")
        log_message "🛠️ MANUAL context detected - Running full diagnostic suite"
        cd "$SCRIPT_DIR"
        echo "Running all validation scripts..."
        bash "$RESTART_SCRIPT"
        echo ""
        bash "$DEPLOY_SCRIPT"
        if [ -f "$DETAILED_SCRIPT" ]; then
            echo ""
            php "$DETAILED_SCRIPT"
        fi
        cd - >/dev/null
        ;;
    
    "status")
        log_message "📊 STATUS check - Quick overview"
        cd "$SCRIPT_DIR"
        bash "$RESTART_SCRIPT"
        cd - >/dev/null
        ;;
    
    *)
        log_message "❓ Unknown context: $CONTEXT"
        log_message "Usage: $0 {deploy|restart|manual|status}"
        log_message "  deploy  - Run after deployment"
        log_message "  restart - Run after service restart"
        log_message "  manual  - Run all diagnostics manually"
        log_message "  status  - Quick status check"
        exit 1
        ;;
esac

log_message "✅ Auto-diagnostic completed for context: $CONTEXT"