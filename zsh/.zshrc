# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='lvim'
else
  export EDITOR='vim'
fi

# Add local bin to path
export PATH="${HOME}/Library/Python/3.8/bin:${HOME}/bin:${PATH}"
export PATH="${HOME}/go/bin:${PATH}"

# Zsh settings commands
alias zshconfig="lvim ~/.zshrc"
alias zshsource="source ~/.zshrc"

# General aliases
alias c='code'
alias g='git'
alias lvim='/Users/reid/.local/bin/lvim'
alias v='/Users/reid/.local/bin/lvim'

# Exa aliases
alias ls='exa -lh --icons --color automatic --no-user --no-time --git --group-directories-first'
alias ll='exa -lah --icons --color automatic --no-user --no-time --git --group-directories-first'
alias tree='exa --tree --icons --color automatic --no-user --no-time --git --group-directories-first'

# Bat aliases
alias cat='bat'

# Stop alacritty errors during ssh
alias ssh='TERM=xterm-256color ssh'

# Enable saceship
[[ $UID == 0 ]] && SPACESHIP_PROMPT_NEED_NEWLINE=true
[[ $SPACESHIP_PROMPT_ADD_NEWLINE == true && $SPACESHIP_PROMPT_NEED_NEWLINE == true ]] && echo -n "$NEWLINE"
SPACESHIP_PROMPT_NEED_NEWLINE=true

# Init starship terminal prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Enable z jump around
. ~/z.sh
