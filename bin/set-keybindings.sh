#!/bin/bash

# Check for graphical session
if [ -z "$DISPLAY" ]; then
  echo "No graphical session detected. Skipping keybinding setup."
  exit 0
fi

# Define path
KEYBINDING_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"

# Set the keybinding
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$KEYBINDING_PATH']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEYBINDING_PATH name "Show Notifications"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEYBINDING_PATH command "gnome-shell --show-notification-log"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEYBINDING_PATH binding "<Super>n"

