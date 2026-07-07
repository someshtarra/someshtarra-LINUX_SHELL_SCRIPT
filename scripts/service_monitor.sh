#!/bin/bash
# ==============================================================================
# Service Monitoring Script
# ==============================================================================
# This script monitors critical systemd services. If a service is found to be
# inactive, it attempts to restart it and logs the event.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -e

# List of critical services to monitor
SERVICES=("nginx" "mysql" "redis-server")
ALERT_EMAIL="ops@example.com"

echo "=== Starting Service Monitor ==="

# Check if systemctl is available
if ! command -v systemctl &>/dev/null; then
    echo "WARNING: 'systemctl' command was not found on this system."
    echo "This script is designed for Linux systems running systemd."
    echo "Simulating service check for educational demonstration:"
    
    # Process-based fallback monitor for systems without systemd (like macOS/docker)
    for service in "${SERVICES[@]}"; do
        # Search process table for the service name
        if pgname=$(pgrep -lf "$service"); then
            echo "OK: Service daemon '$service' is running (PID info: $pgname)"
        else
            echo "ALERT: Service daemon '$service' is not running!"
            echo "  [Simulated] Attempting command: sudo service $service start (or systemctl restart $service)"
        fi
    done
    exit 0
fi

# Actual systemd monitoring logic (runs on systemd-enabled Linux machines)
for service in "${SERVICES[@]}"; do
    if ! systemctl is-active --quiet "$service"; then
        echo "ALERT: Service '$service' is not active!"
        
        # Attempt to restart the service (requires sudo/root privileges)
        echo "Attempting to restart '$service'..."
        if sudo systemctl restart "$service"; then
            echo "Successfully restarted '$service'."
        else
            echo "ERROR: Failed to restart '$service'."
            # Send notification if needed:
            # echo "ALERT: $service failed to restart on $(hostname)" | mail -s "Service Fail Alert" $ALERT_EMAIL
        fi
    else
        echo "OK: Service '$service' is running."
    fi
done

echo "=== Service Monitor Execution Completed ==="
