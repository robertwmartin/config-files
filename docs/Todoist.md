# Todoist Web App Setup

This guide documents the process of integrating Todoist as a standalone web app using Brave and a `.desktop` launcher. The setup is lightweight and avoids installing any unofficial Todoist desktop clients.

---

## Overview

- This approach uses Brave's `--app=` mode to open Todoist in a minimal window.
- The app appears in the system launcher and can be pinned to the taskbar.
- A custom icon is used for a polished appearance.
- This is included in the config-files repository for reproducibility.

---

## Launcher Setup

### .desktop File

Location in repo: `.local/share/applications/todoist.desktop`  
Symlinked to: `~/.local/share/applications/todoist.desktop`

Contents:

```ini
[Desktop Entry]
Name=Todoist
Exec=brave-browser --app=https://todoist.com
Icon=todoist
Terminal=false
Type=Application
Categories=Productivity;
StartupWMClass=Todoist
```

---

## Icon Setup

### Icon File

Location in repo: `icons/todoist.png`  
Symlinked to: `~/.local/share/icons/todoist.png`

Ensure the `Icon=todoist` line in the `.desktop` file references this correctly.

---

## Dotbot Configuration

Example `install.conf.yaml` entries:

```yaml
- link:
    ~/.local/share/applications/todoist.desktop: .local/share/applications/todoist.desktop
- link:
    ~/.local/share/icons/todoist.png: icons/todoist.png
```

---

## Final Notes

- This setup does **not** include offline support — use your mobile app for that.
- No native system tray or notifications — this is just a minimal web app window.
- You must have Brave installed and accessible as `brave-browser`.
