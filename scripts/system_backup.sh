#!/bin/bash
# ==============================================================================
# System Backup Script
# ==============================================================================
# This script performs automated backups of designated directories, compresses
# them as tarballs, and cleans up archives older than the retention period.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -e

# Configuration
BACKUP_DIR="$HOME/backups"
RETAIN_DAYS=30
DATE=$(date +%Y%m%d_%H%M%S)

echo "=== Starting Backup Process ==="
echo "Timestamp: $DATE"

# Check if running as root. Some directories (like /etc) require root permissions.
# If not root, we will log a warning and only backup user-readable directories.
if [ "$EUID" -ne 0 ]; then
    echo "WARNING: You are not running as root. Some system files may be skipped."
    echo "We will perform backups for user-accessible files in your home directory."
    SRC_DIRECTORIES=("$HOME/.ssh" "$HOME/.bash_profile" "$HOME/.zshrc")
else
    echo "Running with administrative (root) privileges."
    SRC_DIRECTORIES=("/etc" "/home" "/var/log")
fi

# Ensure backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# Loop through and backup each source directory
for src in "${SRC_DIRECTORIES[@]}"; do
    if [ -e "$src" ]; then
        # Create a clean folder name for the tar archive
        folder_name=$(basename "$src")
        archive_name="$BACKUP_DIR/${folder_name}_backup_$DATE.tar.gz"
        
        echo "Backing up $src to $archive_name..."
        
        # Create gzipped tarball, redirecting stderr to a log file or ignoring permissions errors
        tar -czf "$archive_name" "$src" 2>/dev/null || true
        
        echo "Successfully created: $archive_name"
    else
        echo "Skipping $src (directory or file does not exist)"
    fi
done

# ------------------------------------------------------------------------------
# Cleanup Phase (Prune backups older than RETAIN_DAYS)
# ------------------------------------------------------------------------------
echo "Cleaning up backups older than $RETAIN_DAYS days in $BACKUP_DIR..."

# Find matching backup tarballs and delete them if they exceed the retention days
find "$BACKUP_DIR" -name "*_backup_*.tar.gz" -type f -mtime +$RETAIN_DAYS -delete

echo "=== Backup Process Completed Successfully ==="
