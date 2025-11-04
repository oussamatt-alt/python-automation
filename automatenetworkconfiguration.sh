#!/bin/bash
# network_config.sh — Automate basic network configuration

# Check if run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root (use sudo)"
  exit 1
fi

# Ask for network interface
read -p "Enter network interface name (e.g. eth0, enp0s3, ens33): " iface

# Show options
echo "Choose network mode:"
echo "1) Static IP"
echo "2) DHCP (automatic)"
read -p "Enter choice [1 or 2]: " choice

if [ "$choice" -eq 1 ]; then
    # Ask for static config
    read -p "Enter static IP (e.g. 192.168.1.100/24): " ip
    read -p "Enter gateway (e.g. 192.168.1.1): " gw
    read -p "Enter DNS (e.g. 8.8.8.8): " dns

    # Apply configuration using nmcli (NetworkManager)
    nmcli con mod "$iface" ipv4.addresses "$ip"
    nmcli con mod "$iface" ipv4.gateway "$gw"
    nmcli con mod "$iface" ipv4.dns "$dns"
    nmcli con mod "$iface" ipv4.method manual
    nmcli con up "$iface"

    echo "✅ Static IP configuration applied successfully!"

elif [ "$choice" -eq 2 ]; then
    nmcli con mod "$iface" ipv4.method auto
    nmcli con up "$iface"
    echo "✅ Switched to DHCP (automatic IP configuration)"
else
    echo "❌ Invalid choice"
    exit 1
fi

# Show current configuration
echo
echo "Current IP configuration for $iface:"
ip addr show "$iface"
