
# Add local bin to path
export PATH="${HOME}/Library/Python/3.8/bin:${HOME}/bin:${PATH}"
export PATH="${HOME}/go/bin:${PATH}"

# Exa aliases
alias ls='exa -lh --icons --color automatic --no-user --no-time --git --group-directories-first'
alias ll='exa -lah --icons --color automatic --no-user --no-time --git --group-directories-first'
alias tree='exa --tree --icons --color automatic --no-user --no-time --git --group-directories-first'

# Bat aliases
alias cat='bat'

# General aliases
alias c='code'
alias {lvim, vi}='/Users/reid/.local/bin/lvim'
alias v='/Users/reid/.local/bin/lvim'

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
