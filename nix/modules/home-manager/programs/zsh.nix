{ pkgs, lib, config, ... }: {
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf config.zsh.enable {
    home.packages = [
      pkgs.zsh
    ];
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
      };
      shellAliases = {
        # Nix commands
        rebuild-system = "sudo nixos-rebuild switch --flake ~/Documents/repos/dotfiles/nix-darwin/";
        rebuild-home = "home-manager switch --flake ~/Documents/repos/dotfiles/nix-darwin/";

        # General aliases
        cp = "cp -iv";
        ".." = "cd ..";
      };

      initExtra = ''
        # Auto attach to Tmux session or create a new session called default
        if ! { [ "$TERM" = "xterm-256color" ] && [ -n "$TMUX" ]; } then
          tmux new -As default
        fi
      '';
    };
  };
}

