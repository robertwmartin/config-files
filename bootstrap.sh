#!/bin/bash
set -e

echo "🚀 Starting bootstrap for config-files"

# Step 1: Ensure Git is installed
if ! command -v git >/dev/null 2>&1; then
  echo "📦 Git not found — installing..."
  sudo apt update && sudo apt install -y git
else
  echo "✅ Git is already installed"
fi

# Step 2: Clone the repo if needed
if [ ! -d "$HOME/config-files" ]; then
  echo "📥 Cloning config-files repo"
  git clone https://github.com/robertwmartin/config-files.git "$HOME/config-files"
else
  echo "📂 config-files already exists"
fi

# Step 3: Run the installer
cd "$HOME/config-files"
echo "⚙️ Running Dotbot installer"
./install.sh

