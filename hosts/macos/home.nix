{ config, ... }:
{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";
  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable packages
  zsh.autoAttachToTmux = true;
  programming.enable = true;

  desktop-applications.enable = true;
  ollama.enable = false;

  firefox.enable = false;
  terminal.enable = true;
  server-tools.enable = true;

  wezterm.enable = true;
  tmux.enable = true;

  skhd.enable = false;

  terraform.enable = true;

  programs.tmux-sessions.projectDirectories = [
    "${config.home.homeDirectory}/Documents/repos"
  ];

  nixpkgs.config.allowUnfree = true;
}
