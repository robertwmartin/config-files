# Software Manifest

This document tracks additional software installed on systems running this dotfiles configuration, beyond what's automated in `install.conf.yaml`.

---

## Automated via Dotbot

See `install.conf.yaml` for the full automation. Key components:
- Kitty terminal
- VSCodium + extensions
- Brave Browser
- Zsh + CLI tools (ripgrep, fzf, bat, fd, lsd, tldr)
- CopyQ clipboard manager
- Git, Vim, Python, Node.js

---

## Snap Packages (Manual Install)
```bash
# Communication & Productivity
sudo snap install discord
sudo snap install signal-desktop
sudo snap install slack
sudo snap install todoist
sudo snap connect todoist:audio-record  # Required for Ramble feature

# Email & Calendar
sudo snap install proton-mail

# Creative & Media
sudo snap install obs-studio
sudo snap install pinta
sudo snap install foliate

# Notes & Knowledge Management
sudo snap install obsidian

# Gaming
sudo snap install steam
```

**Config tracked in dotfiles:**
- Todoist: `.desktop` launcher and icon
- Obsidian: Config directory (check current status)

---

## APT Packages (Manual Install)
```bash
sudo apt install pdfarranger
```

---

## .deb Manual Downloads

**Zoom**
- Download from: https://zoom.us/download
- Install: `sudo dpkg -i zoom_amd64.deb`
- Fix dependencies if needed: `sudo apt install -f`

---

## Optional Installs

See dedicated documentation:
- **Foundry VTT**: `docs/foundry-setup.md`
- **OneDrive rclone**: `docs/OneDriveCloudMount.md`

---

## To Remove

- **Worldographer**: Remove via package manager or delete manually

---

## Notes

- LibreOffice: Ubuntu 24.04 LTS ships with outdated version
  - Current workaround: Manual updates via APT
  - Consider: Switching to Flatpak for newer releases
- Kitty: Using manual install (curl) instead of Snap due to version lag

---

## Last Updated

January 2026
