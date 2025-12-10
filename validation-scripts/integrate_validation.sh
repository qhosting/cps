#!/bin/bash

# Integration script to add validation to existing deploy process
# This script modifies the deploy.sh to include automatic validation

DEPLOY_SCRIPT="/workspace/deploy.sh"
VALIDATION_DIR="/workspace/validation-scripts"
BACKUP_FILE="/workspace/deploy.sh.backup.$(date +%Y%m%d_%H%M%S)"

echo "=== CPS DEPLOY VALIDATION INTEGRATION ==="
echo "Date: $(date)"
echo "========================================"

# Check if deploy.sh exists
if [[ ! -f "$DEPLOY_SCRIPT" ]]; then
    echo "❌ deploy.sh not found at $DEPLOY_SCRIPT"
    echo "Creating new deploy.sh with validation integration..."
    
    # Create new deploy.sh with validation
    cat > "$DEPLOY_SCRIPT" << 'EOF'
#!/bin/bash

# CPS Deployment Script with Validation Integration
set -e

echo "=== CPS DEPLOYMENT STARTED ==="
echo "Date: $(date)"
echo "========================================"

# Function to handle errors
error_exit() {
    echo "❌ ERROR: $1" >&2
    exit 1
}

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Validate Docker installation
log "Validating Docker installation..."
if ! command -v docker >/dev/null 2>&1; then
    error_exit "Docker is not installed"
fi

if ! command -v docker-compose >/dev/null 2>&1; then
    error_exit "Docker Compose is not installed"
fi

log "Docker validation: OK"

# Build and start services
log "Building Docker images..."
docker-compose build --no-cache || error_exit "Docker build failed"

log "Starting services..."
docker-compose up -d || error_exit "Failed to start services"

# Wait for services to be ready
log "Waiting for services to be ready..."
sleep 10

# Validate deployment
log "Running post-deploy validation..."

VALIDATION_DIR="/workspace/validation-scripts"
if [[ -d "$VALIDATION_DIR" ]]; then
    cd "$VALIDATION_DIR"
    
    # Run quick validation first
    log "Running quick validation..."
    if bash quick_validate_easypanel.sh; then
        log "✅ Quick validation: PASSED"
    else
        log "⚠️ Quick validation: FAILED (continuing with detailed check)"
    fi
    
    # Run detailed validation
    log "Running detailed validation..."
    if php validate_deployment_easypanel.php; then
        log "✅ Detailed validation: PASSED"
    else
        log "❌ Detailed validation: FAILED"
        log "Please check validation logs for details"
    fi
    
    # Run post-deploy validation for logging
    log "Running post-deploy validation for logging..."
    bash post_deploy_validation.sh
    
    cd /workspace
else
    log "⚠️ Validation scripts not found, skipping validation"
fi

# Show service status
log "Checking service status..."
docker-compose ps

echo ""
echo "=== DEPLOYMENT COMPLETED ==="
echo "Application URL: https://cps.qhosting.net"
echo "Internal URL: http://localhost:3000"
echo ""
echo "To view validation results:"
echo "  cat validation-scripts/logs/latest_status.txt"
echo "  cat validation-scripts/logs/deploy_validation_*.log"
echo ""
echo "To start monitoring:"
echo "  cd validation-scripts && bash monitor_cps_easypanel.sh --daemon"
echo "========================================"
EOF

    chmod +x "$DEPLOY_SCRIPT"
    echo "✅ New deploy.sh created with validation integration"
else
    echo "📋 Existing deploy.sh found, creating backup..."
    cp "$DEPLOY_SCRIPT" "$BACKUP_FILE"
    echo "✅ Backup created: $BACKUP_FILE"
    
    echo "🔧 Adding validation to existing deploy.sh..."
    
    # Add validation at the end of the deploy process
    cat >> "$DEPLOY_SCRIPT" << 'EOF'

# Add post-deploy validation
echo ""
echo "=== RUNNING POST-DEPLOY VALIDATION ==="

VALIDATION_DIR="/workspace/validation-scripts"
if [[ -d "$VALIDATION_DIR" ]]; then
    cd "$VALIDATION_DIR"
    
    # Run quick validation
    echo "Running quick validation..."
    if bash quick_validate_easypanel.sh; then
        echo "✅ Quick validation: PASSED"
    else
        echo "⚠️ Quick validation: FAILED"
    fi
    
    # Run detailed validation
    echo "Running detailed validation..."
    if php validate_deployment_easypanel.php; then
        echo "✅ Detailed validation: PASSED"
    else
        echo "❌ Detailed validation: FAILED"
    fi
    
    # Run post-deploy validation for logging
    echo "Running post-deploy validation for logging..."
    bash post_deploy_validation.sh
    
    cd /workspace
else
    echo "⚠️ Validation scripts not found, skipping validation"
fi

echo ""
echo "=== VALIDATION COMPLETED ==="
echo "Check results in validation-scripts/logs/"
EOF

    echo "✅ Validation integration completed"
fi

echo ""
echo "=== VALIDATION INTEGRATION SUMMARY ==="
echo "✅ Deploy script updated with validation"
echo "✅ Automatic validation will run after each deploy"
echo ""
echo "Available validation commands:"
echo "  cd validation-scripts"
echo "  bash quick_validate_easypanel.sh        # Quick check"
echo "  php validate_deployment_easypanel.php   # Detailed check"
echo "  bash post_deploy_validation.sh          # Post-deploy check"
echo "  bash monitor_cps_easypanel.sh --daemon  # Continuous monitoring"
echo ""
echo "To view latest status:"
echo "  cat validation-scripts/logs/latest_status.txt"
echo ""
echo "Integration completed successfully!"
echo "========================================"