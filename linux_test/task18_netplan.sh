#!/bin/bash

# Define network configuration
INTERFACE="eth0"
IP_ADDRESS="192.168.1.100/24"
GATEWAY="192.168.1.1"
DNS1="8.8.8.8"
DNS2="8.8.4.4"

# Path to netplan configuration file
NETPLAN_CONFIG="/etc/netplan/01-netcfg.yaml"

# Backup the existing configuration file
echo "Backing up the existing netplan configuration..."
cp $NETPLAN_CONFIG "$NETPLAN_CONFIG.bak"

# Create or modify the netplan configuration
echo "Creating/Modifying netplan configuration..."

cat <<EOL > $NETPLAN_CONFIG
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      dhcp4: no
      addresses:
        - $IP_ADDRESS
      gateway4: $GATEWAY
      nameservers:
        addresses:
          - $DNS1
          - $DNS2
EOL

# Apply the new network configuration
echo "Applying the new network configuration..."
netplan apply

# Verify the new network settings
echo "Network configuration applied successfully. Verifying settings..."
ip a show $INTERFACE
