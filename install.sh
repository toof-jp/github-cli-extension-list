#!/bin/sh

# GitHub CLI Extension Installer
# This script reads extensions from extensions.txt and installs them using gh extension install

# Check if gh command is available
if ! command -v gh >/dev/null 2>&1; then
    echo "Error: GitHub CLI (gh) is not installed. Please install it first."
    exit 1
fi

# Check if extensions.txt exists
if [ ! -f "extensions.txt" ]; then
    echo "Error: extensions.txt not found in the current directory."
    exit 1
fi

# Read extensions from file and install them
echo "Installing GitHub CLI extensions..."
echo

while IFS= read -r line || [ -n "$line" ]; do
    # Skip empty lines and comments
    if [ -z "$line" ] || [ "${line#\#}" != "$line" ]; then
        continue
    fi
    
    # Remove leading/trailing whitespace
    extension=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    if [ -n "$extension" ]; then
        echo "Installing: $extension"
        if gh extension install "$extension" 2>/dev/null; then
            echo "✓ Successfully installed $extension"
        else
            echo "✗ Failed to install $extension (might already be installed)"
        fi
        echo
    fi
done < extensions.txt

echo "Installation complete!"