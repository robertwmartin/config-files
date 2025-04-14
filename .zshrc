# Plugins
plugins=(git)

# Preferred font
export TERMINAL_FONT="JetBrainsMono Nerd Font"

# Aliases
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias ll='ls -al'
alias ..='cd ..'
alias ...='cd ../..'

# Environment
export EDITOR="vim"
export PATH="$HOME/bin:$PATH"

# Enable color support
autoload -U colors && colors

# Minimal two-line prompt
PROMPT='%F{blue}In %~%f
%F{cyan}❯ %f'

# Improve command history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion
autoload -Uz compinit && compinit

# Source any extra config
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Enable colors in manual pages
export LESS='-R'
