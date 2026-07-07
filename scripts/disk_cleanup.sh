#!/bin/bash
# ==============================================================================
# Automated Disk Space Cleanup Script
# ==============================================================================
# This script manages logs and temporary directories to reclaim disk space.
# To ensure safety, it runs checks on directory paths and uses a safe mock path
# by default to prevent accidental data deletion.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -e

# Configuration
DAYS_OLD=30
# Safe directory path for demonstration/practice:
SAFE_CLEANUP_DIR="$HOME/backups/cleanup_demo"

echo "=== Disk Space Management & Cleanup ==="
echo "Target retention: delete files older than $DAYS_OLD days."

# Prepare a safe mock directory if it doesn't exist
if [ ! -d "$SAFE_CLEANUP_DIR" ]; then
    echo "Creating a safe demonstration directory: $SAFE_CLEANUP_DIR"
    mkdir -p "$SAFE_CLEANUP_DIR"
    
    # Create some mock old files for demonstration
    echo "Creating mock files inside $SAFE_CLEANUP_DIR for testing..."
    touch "$SAFE_CLEANUP_DIR/active_log.log"
    touch "$SAFE_CLEANUP_DIR/system_event.log"
    
    # Create an old file using touch timestamp: 40 days ago (YYYYMMDDhhmm)
    # Format: [[CC]YY]MMDDhhmm[.ss]
    d_40_days_ago=$(date -v-40d +%Y%m%d%H%M 2>/dev/null || date --date="40 days ago" +%Y%m%d%H%M)
    touch -t "$d_40_days_ago" "$SAFE_CLEANUP_DIR/old_archive_log.log"
    echo "Created: old_archive_log.log (timestamp set to 40 days ago)"
fi

# List of cleanup paths to monitor (you can add system directories here in production)
CLEANUP_PATHS=("$SAFE_CLEANUP_DIR")

# Process cleanup
for path in "${CLEANUP_PATHS[@]}"; do
    if [ -d "$path" ]; then
        echo "Processing directory: $path"
        
        # Find files matching criteria and list them first
        echo "Files matching pruning criteria (older than $DAYS_OLD days):"
        find "$path" -type f -mtime +$DAYS_OLD -exec ls -lh {} \;
        
        # Perform actual deletion safely
        find "$path" -type f -mtime +$DAYS_OLD -delete
        echo "Cleanup completed for $path."
    else
        echo "Skipping $path (directory not found)"
    fi
done

# ------------------------------------------------------------------------------
# Compress Active Log Files (Daily Maintenance)
# ------------------------------------------------------------------------------
echo "Compressing log files in $SAFE_CLEANUP_DIR..."

# Find uncompressed log files modified today (mtime 0) and compress them
find "$SAFE_CLEANUP_DIR" -name "*.log" -type f -mtime 0 | while read -r logfile; do
    echo "Compressing log: $logfile"
    gzip -f "$logfile"
done

echo "=== Cleanup Script Completed Successfully ==="
