#!/bin/bash

# Ensure applications directory exists
mkdir -p "$HOME/.local/share/applications"

# Copy the desktop entry from the installed kitty.app bundle
cp /opt/kitty/kitty.app/share/applications/kitty.desktop "$HOME/.local/share/applications/kitty.desktop"

# Fix Exec path to match your installed location
sed -i "s|Exec=kitty|Exec=/opt/kitty/kitty.app/bin/kitty|g" "$HOME/.local/share/applications/kitty.desktop"

# Fix Icon path to full path
sed -i "s|Icon=kitty|Icon=/opt/kitty/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" "$HOME/.local/share/applications/kitty.desktop"

# Refresh desktop database
update-desktop-database "$HOME/.local/share/applications"

