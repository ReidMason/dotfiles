# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Add local bin to path
export PATH="${HOME}/Library/Python/3.8/bin:${HOME}/bin:${PATH}"
export PATH="${HOME}/go/bin:${PATH}"

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
  tmux new-session -A -s main
fi

bindkey -e command

# bun completions
[ -s "/Users/reid/.bun/_bun" ] && source "/Users/reid/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f "/Users/reid/.ghcup/env" ] && source "/Users/reid/.ghcup/env" # ghcup-env

# Init zoxide
eval "$(zoxide init zsh)"
