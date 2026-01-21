# Adding App Configs to Dotfiles

This guide provides a standardized process for preserving application configurations in your dotfiles repository.

---

## When to Use This Process

Use this for apps that:
- Follow XDG standard (config in `~/.config/appname/`)
- Have settings you want to preserve across systems
- Have simple, portable configurations

**Examples:** PDF Arranger, CopyQ, many terminal apps, text editors

**Skip for now:** Complex apps with system-specific or binary configs (LibreOffice, browsers with profiles)

---

## Step-by-Step Process

### Step 1: Identify Config Location
```bash
ls -la ~/.config/appname/
```

Look for settings files (usually `.ini`, `.conf`, `.json`, `config`, etc.)

---

### Step 2: Copy to Dotfiles Repo

**For a single config file:**
```bash
mkdir -p ~/config-files/.config/appname
cp ~/.config/appname/config.ini ~/config-files/.config/appname/
```

**For an entire config directory:**
```bash
cp -r ~/.config/appname ~/config-files/.config/
```

---

### Step 3: Add Symlink to install.conf.yaml

Edit `~/config-files/install.conf.yaml` and add to the `- link:` section:

**For single file:**
```yaml
    ~/.config/appname/config.ini: .config/appname/config.ini
```

**For entire directory:**
```yaml
    ~/.config/appname: .config/appname
```

---

### Step 4: Create Symlink Manually (Current System)

**Remove the original:**
```bash
rm ~/.config/appname/config.ini
# OR for directory: rm -rf ~/.config/appname
```

**Create the symlink:**
```bash
ln -s ~/config-files/.config/appname/config.ini ~/.config/appname/config.ini
# OR for directory: ln -s ~/config-files/.config/appname ~/.config/appname
```

---

### Step 5: Verify Symlink
```bash
ls -la ~/.config/appname/config.ini
```

Should show: `config.ini -> /home/rmartin/config-files/.config/appname/config.ini`

---

### Step 6: Commit to Git
```bash
cd ~/config-files
git add .config/appname/
git add install.conf.yaml
git commit -m "Add appname configuration"
git push
```

---

## Optional: Add .gitignore

If the config directory contains cache/temp files you don't want tracked:
```bash
vi ~/config-files/.config/appname/.gitignore
```

**Common excludes:**
```gitignore
cache/
*.lock
*.log
tmp/
*.pid
```

---

## Apps Already Configured

Reference `install.conf.yaml` for the current list. Examples include:
- Kitty terminal
- VSCodium
- CopyQ
- Brave Browser (bookmarks/preferences only)
- Todoist (launcher)
- PDF Arranger

---

## Notes

- Symlinks work even if the app isn't installed yet
- Changes to settings are automatically reflected in the repo
- Remember to commit/push changes periodically
- Test configs on a fresh install to ensure portability

---

## Last Updated

January 2026
