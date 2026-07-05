{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh" // {
      default = true;
    };
    zsh.autoAttachToTmux = lib.mkEnableOption "Auto attach to Tmux session";
    zsh.vaultPath = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        Path to an Obsidian vault. When set, a tmux session named `vault` is
        created on bootstrap alongside `default`.
      '';
    };
    zsh.tmuxAttachSession = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = "Tmux session to attach to after bootstrapping.";
    };
    zsh.tmuxBootstrapSessions = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Tmux session name.";
            };
            path = lib.mkOption {
              type = lib.types.str;
              description = "Working directory for the session.";
            };
          };
        }
      );
      default = [ ];
      description = "Sessions to create on first shell start if they do not already exist.";
    };
  };

  config = lib.mkIf config.zsh.enable {
    zsh.tmuxBootstrapSessions = lib.mkDefault (
      [
        {
          name = "default";
          path = config.home.homeDirectory;
        }
      ]
      ++ lib.optional (config.zsh.vaultPath != null) {
        name = "vault";
        path = config.zsh.vaultPath;
      }
    );

    home.packages = [
      pkgs.zsh
    ];
    programs.zsh = {
      enable = true;
      # Stop the dumb vi mode
      defaultKeymap = "emacs";
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
          # Bootstrap tmux sessions, then attach to the primary session
          if ! { [ "$TERM" = "xterm-256color" ] && [ -n "$TMUX" ]; } && [ "$TERM_PROGRAM" != "vscode" ]; then
            ${lib.concatMapStringsSep "\n" (session: ''
              if ! tmux has-session -t=${lib.escapeShellArg session.name} 2>/dev/null; then
                tmux new-session -d -s ${lib.escapeShellArg session.name} -c ${lib.escapeShellArg session.path}
              fi
            '') config.zsh.tmuxBootstrapSessions}
            exec tmux attach -t ${lib.escapeShellArg config.zsh.tmuxAttachSession}
          fi
        ''}
      '';
    };
  };
}
