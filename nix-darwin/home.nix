{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.neofetch
    pkgs.git
    pkgs.starship
    pkgs.lazygit
    pkgs.neovim
  ];

  home.file = {
    ".config/nvim" = {
      source = ../.config/nvim;
    };
  };

  # programs.zoxide.enable = true;

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
