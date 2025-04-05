#!/bin/bash

# Samba File Server Setup Script
# This script automates the setup of a Samba file server on Ubuntu
# allowing file sharing with Windows clients without password authentication

# Exit on error
set -e

# Display banner
echo "=========================================="
echo "     Samba File Server Setup Script       "
echo "=========================================="
echo

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo privileges"
  exit 1
fi

# Install Samba
echo "Installing Samba..."
apt update
apt install -y samba

# Configuration variables - modify these as needed
WORKGROUP="SAMBAFILESHAREPA"
SHARE_NAME="share"
SHARE_PATH="/srv/samba/share"
SHARE_COMMENT="Ubuntu File Server Share"

# Create share directory
echo "Creating share directory at $SHARE_PATH..."
mkdir -p "$SHARE_PATH"
chown nobody:nogroup "$SHARE_PATH"
chmod 0755 "$SHARE_PATH"

# Backup original config
CONFIG_FILE="/etc/samba/smb.conf"
BACKUP_FILE="/etc/samba/smb.conf.bak"

echo "Backing up original Samba configuration..."
cp "$CONFIG_FILE" "$BACKUP_FILE"

# Update workgroup in config
echo "Configuring Samba..."
sed -i "s/workgroup = .*$/workgroup = $WORKGROUP/" "$CONFIG_FILE"

# Check if share section already exists
if grep -q "^\[$SHARE_NAME\]" "$CONFIG_FILE"; then
  echo "Share [$SHARE_NAME] already exists in config, updating..."
  # Remove existing share section (this is simplistic and might need improvement)
  sed -i "/^\[$SHARE_NAME\]/,/^$/d" "$CONFIG_FILE"
fi

# Add share configuration to smb.conf
cat >> "$CONFIG_FILE" << EOF

[$SHARE_NAME]
    comment = $SHARE_COMMENT
    path = $SHARE_PATH
    browsable = yes
    guest ok = yes
    read only = no
    create mask = 0755
EOF

# Test configuration
echo "Testing Samba configuration..."
testparm -s

# Restart Samba services
echo "Restarting Samba services..."
systemctl restart smbd.service nmbd.service

# Enable services to start at boot
echo "Enabling Samba services to start at boot..."
systemctl enable smbd.service nmbd.service

# Display results
echo
echo "=========================================="
echo "Samba setup complete!"
echo "Share created at: $SHARE_PATH"
echo "Share name: $SHARE_NAME"
echo "Workgroup: $WORKGROUP"
echo
echo "To access from Windows: \\\\$(hostname -I | awk '{print $1}')\\$SHARE_NAME"
echo "=========================================="
echo
echo "WARNING: This configuration allows any client on the network"
echo "to access the share without authentication. For a more secure"
echo "configuration, please refer to the Share Access Control documentation."
