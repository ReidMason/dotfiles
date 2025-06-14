{ pkgs, lib, config, ... }: {
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh" // { default = true; };
    zsh.autoAttachToTmux = lib.mkEnableOption "Auto attach to Tmux session";
  };

  config = lib.mkIf config.zsh.enable {
    home.packages = [
      pkgs.zsh
    ];
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        share = false;
        size = 10000;
        save = 10000;
      };
      shellAliases = {
        # General aliases
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "rm -iv";
        mkdir = "mkdir -pv";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";

        h = "cd ~";

        # System shortcuts
        reload = "source ~/.zshrc";
      };

      # Key bindings for history search
      initContent = ''
        # Bind up and down arrow keys to history search
        bindkey "^[[A" history-search-backward
        bindkey "^[[B" history-search-forward
        
        # Alternative bindings for different terminal types
        bindkey "^[OA" history-search-backward
        bindkey "^[OB" history-search-forward
        
        # Extract various archive formats
        extract() {
          if [ -f "$1" ]; then
            case "$1" in
              *.tar.bz2)   tar xjf "$1"     ;;
              *.tar.gz)    tar xzf "$1"     ;;
              *.bz2)       bunzip2 "$1"     ;;
              *.rar)       unrar x "$1"     ;;
              *.gz)        gunzip "$1"      ;;
              *.tar)       tar xf "$1"      ;;
              *.tbz2)      tar xjf "$1"     ;;
              *.tgz)       tar xzf "$1"     ;;
              *.zip)       unzip "$1"       ;;
              *.Z)         uncompress "$1"  ;;
              *.7z)        7z x "$1"        ;;
              *)           echo "'$1' cannot be extracted via extract()" ;;
            esac
          else
            echo "'$1' is not a valid file"
          fi
        }
        
        # Better completion
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        
        ${lib.optionalString config.zsh.autoAttachToTmux ''
          # Auto attach to Tmux session or create a new session called default
          if ! { [ "$TERM" = "xterm-256color" ] && [ -n "$TMUX" ]; } then
            tmux new -As default
          fi
        ''}
      '';
    };
  };
}

