#!/bin/bash
set -euo pipefail

TARGET="$HOME/.local/share/applications/kitty.desktop"
KITTY_DIR="/opt/kitty/kitty.app"
KITTY_EXEC="$KITTY_DIR/bin/kitty"
KITTY_ICON="$KITTY_DIR/share/icons/hicolor/256x256/apps/kitty.png"
SOURCE_DESKTOP="$KITTY_DIR/share/applications/kitty.desktop"

# Exit early if Kitty isn't installed
if [ ! -x "$KITTY_EXEC" ]; then
  echo "❌ Kitty not found at $KITTY_EXEC"
  exit 1
fi

# Ensure applications directory exists
mkdir -p "$(dirname "$TARGET")"

# Remove existing .desktop file or symlink
if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  echo "🧹 Removing old $TARGET"
  rm -f "$TARGET"
fi

# Copy and patch the .desktop file
echo "📋 Copying launcher from $SOURCE_DESKTOP"
cp "$SOURCE_DESKTOP" "$TARGET"

echo "🛠️  Patching Exec and Icon paths"
sed -i "s|Exec=kitty|Exec=$KITTY_EXEC|g" "$TARGET"
sed -i "s|Icon=kitty|Icon=$KITTY_ICON|g" "$TARGET"

# Refresh launcher database
echo "🔄 Updating desktop database"
update-desktop-database "$(dirname "$TARGET")"

echo "✅ Kitty launcher installed and updated: $TARGET"

