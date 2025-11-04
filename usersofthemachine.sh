#!/bin/bash
# list_users.sh
# Lists users on the machine: all users, human/regular users (UID >= 1000),
# and system users (UID < 1000). Uses getent so it works with /etc/passwd or NSS.

set -u

# Function to print a header
hdr() { printf "\n### %s ###\n" "$1"; }

# Use getent to get passwd entries (works for /etc/passwd and NSS)
if ! command -v getent >/dev/null 2>&1; then
  echo "Error: getent not found. On most Linux systems install glibc-common or use /etc/passwd directly."
  exit 1
fi

# All users (username:uid:home:shell)
hdr "All users (username : UID : home : shell)"
getent passwd | awk -F: '{ printf "%-20s : %-5s : %-30s : %s\n", $1, $3, $6, $7 }'

# Human/regular users: commonly UID >= 1000 (on many distros). Exclude nobody (UID 65534).
hdr "Human / regular users (UID >= 1000)"
getent passwd | awk -F: '($3 >= 1000 && $3 < 65534) { printf "%-20s : %-5s : %-30s : %s\n", $1, $3, $6, $7 }'

# System users: UID < 1000 (service/system accounts)
hdr "System users (UID < 1000)"
getent passwd | awk -F: '($3 < 1000) { printf "%-20s : %-5s : %-30s : %s\n", $1, $3, $6, $7 }'

# Summary counts
total=$(getent passwd | wc -l)
humans=$(getent passwd | awk -F: '($3 >= 1000 && $3 < 65534) { print }' | wc -l)
systems=$(getent passwd | awk -F: '($3 < 1000) { print }' | wc -l)

hdr "Summary"
echo "Total users : $total"
echo "Human users : $humans"
echo "System users: $systems"

exit 0
