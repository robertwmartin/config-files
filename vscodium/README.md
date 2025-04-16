# VSCodium Setup

This folder contains configuration files and documentation to set up VSCodium with preferred extensions, settings, and tools — including Windsurf (formerly Codeium) for AI-powered autocompletion.

---

## 📦 Included

- `settings.json` – Core editor configuration
- `vscodium-extensions.txt` – List of installed extensions
- `vim-cheatsheet.md` – Quick reference for Vim-mode editing (see `/docs`)

---

## 🚀 Setup Instructions

### 1. Install VSCodium (Debian-based)

```bash
# Add GPG key
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/vscodium-archive-keyring.gpg > /dev/null

# Add repository
echo "deb [signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main" \
  | sudo tee /etc/apt/sources.list.d/vscodium.list

# Install
sudo apt update
sudo apt install codium
---

### 2. Install Extensions

```bash
xargs -n 1 codium --install-extension < vscodium-extensions.txt
```

---

### 3. Copy Settings

```bash
mkdir -p ~/.config/VSCodium/User/
cp settings.json ~/.config/VSCodium/User/
```

---

## 🤖 Installing Windsurf (Codeium) Plugin

1. Download the `.vsix` file from [Open VSX](https://open-vsx.org/extension/Codeium/codeium)

2. Install it manually:

```bash
codium --install-extension Codeium.codeium-<version>.vsix
```

3. Launch VSCodium and open the Command Palette (`Ctrl+Shift+P`)

4. Run `Windsurf: Login` and authenticate with GitHub or Google

5. Copy your authentication token when prompted

6. Open the Command Palette again, run `Windsurf: Provide Authentication Token`, and paste it in

7. You should see a welcome notification confirming successful login

---

## 📘 Notes

- Windsurf may still appear under the extension ID `codeium.codeium`
- Vim keybindings are enabled via the `vscodevim` extension
- Nord Arctic theme is recommended for visual consistency with terminal and other tools
```
---

