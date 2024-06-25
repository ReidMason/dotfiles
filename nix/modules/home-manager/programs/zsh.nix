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
      shellAliases = {
        # Nix commands
        rebuild-system = "sudo nixos-rebuild switch --flake ~/Documents/repos/dotfiles/nix-darwin/";
        rebuild-home = "home-manager switch --flake ~/Documents/repos/dotfiles/nix-darwin/";

        # Eza aliases
        ls = "eza -lh --icons --no-user --group-directories-first";
        ll = "eza -lah --icons --no-user --no-time --group-directories-first";
        tree = "eza --tree --icons --no-user --no-time --group-directories-first";

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

