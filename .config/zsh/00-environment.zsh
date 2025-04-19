# Preferred font
export TERMINAL_FONT="JetBrainsMono Nerd Font"

# Environment
export EDITOR="vim"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Enable colors in manual pages
export LESS='-R'

# Hardcoded Nord terminal colors (replaces broken nord-dircolors file)
export LS_COLORS='di=0;38;5;110:ln=0;38;5;109:fi=0;38;5;245:*.sh=1;38;5;108:*.md=38;5;180:*.zip=38;5;203:*.tar=38;5;203:*.gz=38;5;203:*.jpg=38;5;217:*.png=38;5;217'

# Enable green-screen style syntax highlighting
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Make all typed input green
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#B48EAD'
ZSH_HIGHLIGHT_STYLES[path]='none'  # Disable underline on file paths

ZSH_HIGHLIGHT_STYLES[path]='fg=#88C0D0'  # Soft blue for paths

