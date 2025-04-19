# Preferred font
export TERMINAL_FONT="JetBrainsMono Nerd Font"

# Environment
export EDITOR="vim"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Enable colors in manual pages
export LESS='-R'

# Nord terminal colors (used by ls, eza, etc.)
if [ -f "$HOME/.dircolors" ]; then
  eval "$(dircolors -b $HOME/.dircolors)"
fi

