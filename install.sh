#!/usr/bin/env bash

# install.sh - Install ask CLI tool system-wide

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Installing 'ask' CLI tool..."

# Check if script exists
if [ ! -f "ask" ]; then
    echo "Error: 'ask' script not found in current directory" >&2
    exit 1
fi

# Make executable
chmod +x ask

# Install to /usr/local/bin
echo "Installing to /usr/local/bin/ask (requires sudo)..."
sudo cp ask /usr/local/bin/

echo -e "${GREEN}✓ Installation complete!${NC}"
echo

# Get OpenRouter IPs
echo "Resolving OpenRouter DNS..."
IPS=$(dig +short openrouter.ai 2>/dev/null | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' || nslookup openrouter.ai 2>/dev/null | grep -A1 "Name:" | grep "Address:" | awk '{print $2}' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')

if [ -n "$IPS" ]; then
    echo -e "${YELLOW}OpenRouter IP addresses:${NC}"
    echo "$IPS"
    echo
    echo "To improve performance, you can add these to /etc/hosts:"
    echo "----------------------------------------"
    for IP in $IPS; do
        echo "$IP    openrouter.ai"
    done | head -1  # Only show first IP as hosts file needs single entry
    echo "----------------------------------------"
    echo
    echo "Add with: sudo nano /etc/hosts"
    echo "(Only add ONE IP address to avoid conflicts)"
else
    echo "Could not resolve OpenRouter IPs. Network may be unavailable."
fi

echo
echo -e "${GREEN}Usage:${NC}"
echo "  ask 'What is 2+2?'"
echo "  ask -g 'Explain quantum computing'"
echo "  ask --help"
echo
echo "Don't forget to set your API key:"
echo "  export OPENROUTER_API_KEY='your-key-here'"