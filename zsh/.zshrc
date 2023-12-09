# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

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

# Bat aliases
alias cat='bat'

# Enable saceship
[[ $UID == 0 ]] && SPACESHIP_PROMPT_NEED_NEWLINE=true
[[ $SPACESHIP_PROMPT_ADD_NEWLINE == true && $SPACESHIP_PROMPT_NEED_NEWLINE == true ]] && echo -n "$NEWLINE"
SPACESHIP_PROMPT_NEED_NEWLINE=true

# Init starship terminal prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Auto attach to Tmux session or create a new session called main
if ! { [ "$TERM" = "xterm-256color" ] && [ -n "$TMUX" ]; } then
  tmux new-session -A -s main
fi

# Enable z jump around
. ~/z.sh

bindkey -e command

# bun completions
[ -s "/Users/reid/.bun/_bun" ] && source "/Users/reid/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f "/Users/reid/.ghcup/env" ] && source "/Users/reid/.ghcup/env" # ghcup-env