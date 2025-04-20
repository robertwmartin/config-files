#!/bin/bash

DESKTOP_SYMLINK="$HOME/.local/share/applications/kitty.desktop"
SOURCE_FILE="$HOME/.config/kitty/kitty.conf"

# Exit early if the source file doesn't exist
if [ ! -f "$SOURCE_FILE" ] && [ ! -L "$SOURCE_FILE" ]; then
  echo "⚠️ Kitty config not found: $SOURCE_FILE"
  echo "Skipping fix-kitty-desktop.sh"
  exit 0
fi

# Exit early if the symlink is broken or doesn't exist
if [ ! -L "$DESKTOP_SYMLINK" ]; then
  echo "⚠️ Kitty .desktop symlink not found or not a symlink: $DESKTOP_SYMLINK"
  echo "Skipping fix-kitty-desktop.sh"
  exit 0
fi

set -e

TARGET="$HOME/.local/share/applications/kitty.desktop"

# Remove broken symlink if it exists
if [ -L "$TARGET" ] && [ ! -e "$TARGET" ]; then
  echo "Removing dangling symlink: $TARGET"
  rm "$TARGET"
fi

# Ensure applications directory exists
mkdir -p "$HOME/.local/share/applications"

# Copy the desktop entry from the installed kitty.app bundle
cp /opt/kitty/kitty.app/share/applications/kitty.desktop "$TARGET"

# Fix Exec path
sed -i "s|Exec=kitty|Exec=/opt/kitty/kitty.app/bin/kitty|g" "$TARGET"

# Fix Icon path
sed -i "s|Icon=kitty|Icon=/opt/kitty/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" "$TARGET"

# Update desktop database
update-desktop-database "$HOME/.local/share/applications"

echo "✅ kitty.desktop fixed and ready"

