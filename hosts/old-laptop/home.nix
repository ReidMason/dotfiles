{ config, pkgs, pkgs-unstable, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/home/reid";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.waybar
    pkgs.pavucontrol
  ];

  # Enable packages
  programming.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  terminal-apps.enable = true;

  # tmux.enable = true;
  wezterm.enable = true;
  # ktmux-sessionizer.enable = true;

  nixpkgs.config.allowUnfree = true;
}
