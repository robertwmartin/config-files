#!/bin/bash
# Set GNOME keybinding for system notifications to Meta+N

gsettings set org.gnome.settings-daemon.plugins.media-keys show-notifications '<Super>n'

# Optional: Unbind existing shortcut (if known)
# gsettings set org.gnome.settings-daemon.plugins.media-keys show-notifications '@as []'

