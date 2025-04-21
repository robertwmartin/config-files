#!/bin/bash
set -euo pipefail

KITTY_REPO="kovidgoyal/kitty"
INSTALL_DIR="/opt/kitty"
BIN_PATH="$INSTALL_DIR/kitty.app/bin/kitty"
TMP_DIR="/tmp/kitty-update"
ARCHIVE_NAME="kitty.app.tar.xz"

trap 'echo "❌ Kitty update failed"; notify-send "Kitty Updater" "❌ Update failed"' ERR

LATEST_VERSION=$(curl -s "https://api.github.com/repos/$KITTY_REPO/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' | sed 's/^v//')
CURRENT_VERSION=$($BIN_PATH --version | awk '{print $2}')

if [[ "$LATEST_VERSION" == "$CURRENT_VERSION" ]]; then
    echo "✅ Kitty is already up to date ($CURRENT_VERSION)"
    notify-send "Kitty Updater" "✅ Already up to date ($CURRENT_VERSION)"
    exit 0
fi

echo "⬇️ New version available: $LATEST_VERSION (current: $CURRENT_VERSION)"
notify-send "Kitty Updater" "⬇️ Updating to $LATEST_VERSION..."

mkdir -p "$TMP_DIR"
cd "$TMP_DIR"
wget -q "https://github.com/$KITTY_REPO/releases/download/$LATEST_VERSION/$ARCHIVE_NAME"

echo "📁 Extracting..."
tar -xf "$ARCHIVE_NAME"

echo "🛡️ Backing up current Kitty..."
sudo mv "$INSTALL_DIR" "${INSTALL_DIR}_backup_$(date +%Y%m%d_%H%M%S)"

echo "🚀 Installing new Kitty..."
sudo mv kitty.app "$INSTALL_DIR"
sudo chown -R root:root "$INSTALL_DIR"
sudo chmod -R a+rx "$INSTALL_DIR"

echo "🧹 Cleaning up..."
rm -rf "$TMP_DIR"

echo "✅ Kitty $LATEST_VERSION installed successfully!"
notify-send "Kitty Updater" "✅ Updated to $LATEST_VERSION"

