#!/usr/bin/env bash

# Quickbox-Qt Installation Script
# MIT License - Copyright (c) 2026 Musqz

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}=== Quickbox-Qt Installer ===${NC}\n"

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Error: This script must be run as root${NC}"
    echo "Try: sudo ./install.sh"
    exit 1
fi

# Install main executable
echo "Installing quickbox to /usr/local/bin/"
cp quickbox /usr/local/bin/
chmod +x /usr/local/bin/quickbox
echo -e "${GREEN}✓ quickbox installed${NC}"

# Install desktop file
echo "Installing desktop file..."
cp pkg/quickbox.desktop /usr/share/applications/
echo -e "${GREEN}✓ quickbox.desktop installed${NC}"

# Install translations
if [[ -d "translations" ]]; then
    echo "Installing translations..."
    mkdir -p /usr/share/quickbox-qt/translations
    cp translations/*.json /usr/share/quickbox-qt/translations/
    echo -e "${GREEN}✓ Translations installed${NC}"
fi

# Install version file
if [[ -f "version.txt" ]]; then
    mkdir -p /usr/share/quickbox-qt
    cp version.txt /usr/share/quickbox-qt/version.txt
    echo -e "${GREEN}✓ Version file installed${NC}"
fi

# Install icon
if [[ -f "icons/hicolor/scalable/apps/quickbox.svg" ]]; then
    echo "Installing icon..."
    mkdir -p "/usr/share/icons/hicolor/scalable/apps"
    cp "icons/hicolor/scalable/apps/quickbox.svg" \
       "/usr/share/icons/hicolor/scalable/apps/quickbox.svg"
    gtk-update-icon-cache -q -t -f /usr/share/icons/hicolor 2>/dev/null || true
    echo -e "${GREEN}✓ Icon installed${NC}"
fi

echo ""
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo ""
echo "Usage: quickbox"
echo "To uninstall: sudo ./uninstall.sh"
