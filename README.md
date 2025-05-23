



## Notes on Terminal Color and File Listing Tools

### Why we use `lsd` instead of `ls` or `eza`

- `lsd` supports true color configuration via `~/.config/lsd/config.yaml`
- It includes icon support (with Nerd Fonts) and group-directory sorting
- It works consistently across machines without relying on `$LS_COLORS` or `dircolors`
- Previous tools (`eza`, `ls`) either ignored Nord themes or rendered ANSI-style defaults

### Why we hardcoded `LS_COLORS`

- The `nord-dircolors` file from Arctic Ice Studio no longer outputs Nord-styled values
- `$LS_COLORS` was manually set to reflect Nord-friendly colors
- Eventually replaced by `lsd` config, which offers better control and consistency

### Kitty remote control and theme updates

To allow theme updates (like background color changes) from the shell, enable this line in `kitty.conf`:

```ini
remote_control socket=/tmp/kitty.sock

Without this, commands like kitty @ set-colors will not work.

Kitty keyboard shortcuts

These keybindings are defined in kitty.conf:
Shortcut	Action
Ctrl+Shift+T	Open a new tab
Ctrl+Shift+W	Close the current tab
Ctrl+Shift+Right	Switch to next tab
Ctrl+Shift+Left	Switch to previous tab
Ctrl+Shift+N	Launch a new independent Kitty window

    The Ctrl+Shift+N shortcut uses launch --detach to open a separate Kitty instance on another monitor or workspace.
