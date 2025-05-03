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
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        share = false;
      };
      shellAliases = {
        # General aliases
        cp = "cp -iv";
        ".." = "cd ..";
      };

      initExtra = lib.mkIf config.zsh.autoAttachToTmux ''
        # Auto attach to Tmux session or create a new session called default
        if ! { [ "$TERM" = "xterm-256color" ] && [ -n "$TMUX" ]; } then
          tmux new -As default
        fi
      '';
    };
  };
}

