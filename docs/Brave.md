# Brave Browser Settings Sync

This guide documents how to track and restore Brave browser settings as part of the Linux base install.

---

## Overview

Brave settings are stored in the Chromium-style directory:

```
~/.config/BraveSoftware/Brave-Browser/Default/
```

For a portable setup, I **include**:

- `Bookmarks`: All user-created bookmarks
- `Preferences`: General browser settings (e.g., search engine, theme)

I **exclude**:

- Cache, history, favicons, and extension binaries

---

## Files Tracked in Repo

**Tracked paths:**

```
.config/BraveSoftware/Brave-Browser/Default/Bookmarks
.config/BraveSoftware/Brave-Browser/Default/Preferences
```

These files are included in the repo and symlinked via Dotbot.

---

## Dotbot Configuration

Add the following to `install.conf.yaml`:

```yaml
- link:
    ~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks: .config/BraveSoftware/Brave-Browser/Default/Bookmarks
    ~/.config/BraveSoftware/Brave-Browser/Default/Preferences: .config/BraveSoftware/Brave-Browser/Default/Preferences
```

This ensures the settings are restored to the appropriate path after installation.

---

## .gitignore

To avoid tracking large or sensitive files, we include:

**.config/BraveSoftware/Brave-Browser/Default/.gitignore**

```gitignore
History
Favicons
Top Sites
```

---

## Extensions

The `Extensions/` directory is **not** tracked. This is intentional:

- Brave may re-download extensions
- Extension data is often tied to specific OS or session states
- It may break portability

---

## Final Notes

- Bookmarks were imported from the user's Windows installation and can be updated later.
- Extensions can be reinstalled manually or through Brave's sync feature if needed.

--- 

## ## Tags

 #config #May2025
