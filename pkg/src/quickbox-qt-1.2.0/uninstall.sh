#!/bin/bash

# Quickbox-Qt Uninstall Script
# MIT License - Copyright (c) 2026 Musqz

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${RED}=== Quickbox-Qt Uninstaller ===${NC}\n"

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Error: This script must be run as root${NC}"
    echo "Try: sudo ./uninstall.sh"
    exit 1
fi

echo -e "${RED}WARNING: This will remove Quickbox-Qt${NC}"
echo "Configuration in ~/.config/quickbox/ will NOT be deleted"
echo ""
read -p "Continue with uninstall? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo "Uninstalling..."

if [[ -f /usr/local/bin/quickbox ]]; then
    rm /usr/local/bin/quickbox
    echo -e "${GREEN}✓ Removed /usr/local/bin/quickbox${NC}"
fi

if [[ -f /usr/share/applications/quickbox.desktop ]]; then
    rm /usr/share/applications/quickbox.desktop
    echo -e "${GREEN}✓ Removed quickbox.desktop${NC}"
fi

if [[ -d /usr/share/quickbox-qt ]]; then
    rm -rf /usr/share/quickbox-qt
    echo -e "${GREEN}✓ Removed /usr/share/quickbox-qt${NC}"
fi

for size in 16 22 24 32 48 64 96 128 256 512; do
    icon="/usr/share/icons/hicolor/${size}x${size}/apps/quickbox.png"
    [[ -f "$icon" ]] && rm "$icon"
done
gtk-update-icon-cache -q -t -f /usr/share/icons/hicolor 2>/dev/null || true
echo -e "${GREEN}✓ Icons removed${NC}"

echo ""
echo -e "${GREEN}=== Uninstall Complete ===${NC}"
echo ""
echo "Note: Configuration in ~/.config/quickbox/ was NOT deleted"
echo "To completely remove: rm -rf ~/.config/quickbox/"
