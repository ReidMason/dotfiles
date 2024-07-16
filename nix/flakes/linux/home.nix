{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/home/reid";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [];

  wezterm.enable = false;
  tmux.enable = false;
  tmux-sessionizer.enable = false;

  docker.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
