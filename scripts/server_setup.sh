#!/bin/bash
# ==============================================================================
# Server Setup Script (Debian/Ubuntu Specific)
# ==============================================================================
# This script automates initial configuration of a newly provisioned Debian/Ubuntu
# server. It updates packages, installs utility tools, sets the timezone,
# configures basic firewall (UFW), and sets up logging templates.
# ==============================================================================

# Exit on any error
set -e

echo "=== Automating Initial Server Setup ==="

# Check OS requirement (Debian/Ubuntu)
if [ ! -f /etc/debian_version ]; then
    echo "ERROR: This script is intended for Debian or Ubuntu systems only."
    echo "Current platform does not appear to support the 'apt' package manager."
    echo "Showing a simulated checklist of operations that would be executed:"
    echo "  [Simulated] 1. apt update && apt upgrade -y"
    echo "  [Simulated] 2. apt install -y curl wget git htop vim build-essential"
    echo "  [Simulated] 3. useradd -r -s /bin/bash app-user"
    echo "  [Simulated] 4. timedatectl set-timezone Asia/Kolkata"
    echo "  [Simulated] 5. ufw allow 22/tcp, 80/tcp, 443/tcp && ufw enable"
    echo "  [Simulated] 6. Setup log rotation configuration in /etc/logrotate.d/app"
    exit 0
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run as root (using sudo)."
    exit 1
fi

# 1. Update Package Listings & Upgrade Core Packages
echo "Updating packages..."
apt update && apt upgrade -y

# 2. Install Essential Sysadmin Tools
echo "Installing essential utilities..."
apt install -y curl wget git htop vim build-essential ufw

# 3. Create a System Service User
if ! id "app-user" &>/dev/null; then
    echo "Creating dedicated application service user..."
    useradd -r -s /bin/bash app-user
else
    echo "Service user 'app-user' already exists."
fi

# 4. Set Regional Timezone
echo "Setting timezone to Asia/Kolkata..."
timedatectl set-timezone Asia/Kolkata

# 5. Configure Firewall (Uncomplicated Firewall)
echo "Configuring firewall rules..."
ufw allow 22/tcp   # SSH
ufw allow 80/tcp   # HTTP
ufw allow 443/tcp  # HTTPS
echo "y" | ufw enable

# 6. Configure Application Log Rotation Template
echo "Configuring log rotation for app..."
cat > /etc/logrotate.d/app << EOF
/var/log/app/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 app-user app-user
}
EOF

echo "=== Initial Server Setup Completed Successfully ==="
