#!/bin/bash

# Ask for the file path
read -p "Enter the file path: " file

# Ask for the new owner
read -p "Enter the new owner username: " new_owner

# Change the owner
sudo chown "$new_owner" "$file"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "✅ Owner changed successfully!"
    echo "📄 Updated file info:"
    ls -l "$file"
else
    echo "❌ Failed to change the owner. Please check the file path or permissions."
fi
