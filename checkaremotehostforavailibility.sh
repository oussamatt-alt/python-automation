#!/bin/bash
# check_host.sh — Check if a remote host is available

# Ask the user for the host to check
read -p "Enter the hostname or IP address to check: " host

# Ping the host (1 packet, wait max 3 seconds)
if ping -c 1 -W 3 "$host" > /dev/null 2>&1; then
    echo "✅ The host '$host' is reachable!"
else
    echo "❌ The host '$host' is NOT reachable!"
fi
