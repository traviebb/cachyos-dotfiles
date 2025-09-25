#!/bin/bash

# System Update Script for CachyOS
# Updates both official repos and AUR packages

set -e

echo "🚀 Starting system update..."

# Update official repositories
echo "📦 Updating official packages..."
sudo pacman -Syu

# Update AUR packages
if command -v yay >/dev/null 2>&1; then
    echo "🎯 Updating AUR packages..."
    yay -Syu --noconfirm
else
    echo "⚠️  yay not found, skipping AUR updates"
fi

# Clean package cache
echo "🧹 Cleaning package cache..."
sudo pacman -Sc --noconfirm

# Update flatpak if installed
if command -v flatpak >/dev/null 2>&1; then
    echo "📱 Updating Flatpak packages..."
    flatpak update -y
fi

echo "✅ System update completed!"