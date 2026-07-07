#!/bin/bash
# ==============================================================================
# Disk Usage Monitoring Script
# ==============================================================================
# This script monitors disk partition capacities against a warning threshold
# and alerts if space usage is too high.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -e

# Configurable Warning Threshold (in percentage)
THRESHOLD=80
ALERT_EMAIL="admin@example.com"

echo "=== Starting Disk Space Monitor ==="
echo "Alert Threshold: $THRESHOLD%"

# Get disk space stats, filter header, parse percentage, and check limits
df -h | awk 'NR>1 {print $0}' | while read -r line; do
    # Extract the usage percentage (usually column 5, e.g., "78%")
    # Works for both Linux and macOS systems
    usage_pct=$(echo "$line" | awk '{print $5}' | sed 's/%//g')
    
    # Extract mount point (usually column 6 or last column)
    mount_point=$(echo "$line" | awk '{print $NF}')
    
    # Check if usage_pct is a valid integer before comparing
    if [[ "$usage_pct" =~ ^[0-9]+$ ]]; then
        if [ "$usage_pct" -gt "$THRESHOLD" ]; then
            echo "ALERT: Partition mounted on '$mount_point' exceeds threshold ($usage_pct% used)."
            
            # Note: In production, you would configure an email agent like mailx/sendmail:
            # echo "Warning: partition '$mount_point' is at $usage_pct% capacity!" | mail -s "Disk Alert: $mount_point" $ALERT_EMAIL
        else
            echo "OK: Partition '$mount_point' is at $usage_pct% capacity."
        fi
    fi
done

echo "=== Disk Space Monitor Completed ==="
