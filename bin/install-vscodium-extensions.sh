#!/bin/bash
set -e

EXT_FILE="$HOME/config-files/vscodium-extensions.txt"

if ! command -v codium &> /dev/null; then
  echo "❌ VSCodium is not installed or 'codium' is not in PATH"
  exit 1
fi

if [ ! -f "$EXT_FILE" ]; then
  echo "❌ Extension list not found at: $EXT_FILE"
  exit 1
fi

echo "📦 Installing VSCodium extensions..."

while IFS= read -r extension || [[ -n "$extension" ]]; do
  echo "➡️  Installing $extension"
  codium --install-extension "$extension" --force
done < "$EXT_FILE"

echo "✅ All extensions installed."

