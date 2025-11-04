#!/bin/bash
echo "=== File Permission Checker ==="

# Ask for the file path
read -p "Enter the full file path: " filepath

# Check if the file exists
if [ ! -e "$filepath" ]; then
    echo "❌ The file does not exist!"
    exit 1
fi

# Show the permissions in human-readable form
echo "✅ File exists: $filepath"
echo "Permissions:"
ls -l "$filepath"

# Optional: show symbolic permissions only (rwxr-xr--)
perm=$(stat -c "%A" "$filepath")
echo "Symbolic permissions: $perm"

# Optional: show numeric permissions (e.g. 755)
numperm=$(stat -c "%a" "$filepath")
echo "Numeric permissions: $numperm"
