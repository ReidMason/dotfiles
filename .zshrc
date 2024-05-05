# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Add local bin to path
export PATH="${HOME}/Library/Python/3.8/bin:${HOME}/bin:${PATH}"
export PATH="${HOME}/go/bin:${PATH}"
export PATH="${HOME}/scripts:${PATH}"

export TMS_CONFIG_FILE="${HOME}/.config/tms/tms.toml"

# Zsh settings commands
alias zshsource="source ~/.zshrc"

# General aliases
alias g='git'
alias lvim='/Users/reid/.local/bin/lvim'
alias python='python3'

# Exa aliases
alias ls='exa -lh --icons --color automatic --no-user --no-time --git --group-directories-first'
alias ll='exa -lah --icons --color automatic --no-user --no-time --git --group-directories-first'
alias tree='exa --tree --icons --color automatic --no-user --no-time --git --group-directories-first'

alias cp='cp -iv'
alias ..='cd ..'

# Bat aliases
alias cat='bat'

# Init starship terminal prompt
eval "$(starship init zsh)"

# Auto attach to Tmux session or create a new session called main
if ! { [ "$TERM" = "xterm-256color" ] && [ -n "$TMUX" ]; } then
  tmux-new
fi

bindkey -e command

# bun completions
[ -s "/Users/reid/.bun/_bun" ] && source "/Users/reid/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f "/Users/reid/.ghcup/env" ] && source "/Users/reid/.ghcup/env" # ghcup-env

# Init zoxide
eval "$(zoxide init --cmd cd zsh)"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
