# CopyQ Clipboard Manager Setup

This guide outlines how CopyQ is configured in the base Linux install and how to integrate its settings into your workflow.

---

## Overview

CopyQ is a powerful clipboard manager that runs in the background and keeps a searchable history of copied content, including text, images, and HTML.

---

## Key Features

- Automatically stores clipboard history
- Popup menu for pasting past entries
- Tabs to organize items
- Pin frequently used clips
- Custom commands and scripting

---

## Keyboard Shortcuts

### Final Config

| Action              | Shortcut | Notes                              |
|---------------------|----------|------------------------------------|
| Show clipboard menu | F9       | Reliable in all contexts, including Kitty |
| Paste in terminal   | Ctrl+Shift+V | Default for most terminals     |
| Show notifications  | Meta+N   | GNOME system notification shortcut |

> F9 was chosen for reliability and ease of use, as Meta+V may behave inconsistently in terminal emulators like Kitty.

---

## GNOME Keybinding Script

To remap the system notification shortcut to `Meta+N`, the install process includes:

**Script:** `bin/set-keybindings.sh`

```bash
gsettings set org.gnome.settings-daemon.plugins.media-keys show-notifications '<Super>n'
```

Included via Dotbot:

```yaml
- shell:
    - bin/set-keybindings.sh
```

---

## Configuration Sync

To preserve CopyQ preferences across installs:

**Tracked path:** `.config/copyq`  
**Symlinked to:** `~/.config/copyq`

Add to your `install.conf.yaml`:

```yaml
- link:
    ~/.config/copyq: .config/copyq
```

---

## Git Ignore (Optional)

To exclude actual clipboard history from version control (recommended):

**Create:** `.config/copyq/.gitignore`

```gitignore
*.dat
```

This prevents files like `copyq_tab_*.dat` from being committed.

---

## Final Notes

- CopyQ is already installed as part of the base system
- It will launch automatically and preserve your preferred shortcuts
- F9 opens the clipboard history menu reliably across environments
