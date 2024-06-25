{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/home/reid";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.zoxide
    pkgs.starship
    pkgs.git
    pkgs.stow
    pkgs.lazygit
    pkgs.zsh
    pkgs.neovim
    pkgs.ripgrep
    pkgs.libgccjit

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/nvim" = {
      source = ../.config/nvim;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/reid/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    # Without this tmux will crash on a machine sshed into this machine
    # might be fixed for tmux versions after 3.4
    TMUX = "meow";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      rebuild-system = "sudo nixos-rebuild switch --flake ~/dotfiles/nix";
      rebuild-home = "home-manager switch --flake ~/dotfiles/nix";
      cp = "cp -iv";
      cd = "z";
    };
  };

  programs.zoxide.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = pkgs.lib.concatStrings [
        "$hostfile"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$fill"
        "$nodejs"
        "$golang"
        "$python"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      fill = {
        symbol = " ";
      };
      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style) ";
      };
      git_status = {
        format = "([$ahead_behind]($style))";
        ahead = "[⇡{count}](green)";
        diverged = "[⇡$ahead_count(green)][⇣$behind_count(red)]";
        behind = "[⇣$count(red)]";
      };
      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };
      git_metrics = {
        disabled = true;
      };
      nodejs = {
        format = "[$symbol($version )]($style)";
      };
      rust = {
        format = "[$symbol($version )]($style)";
      };
      golang = {
        format = "[$symbol($version )]($style)";
      };
      python = {
        format = "[$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Reid Mason";
    userEmail = "maddogshain132@gmail.com";
  };
}
