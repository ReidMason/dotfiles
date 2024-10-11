{ config, pkgs, lib, ... }:
{
  home.username = "nia";
  home.homeDirectory = "/home/nia";
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [];

  terminal.enable = true;
  git.enable = true;
  wezterm.enable = true;
  hyprland.enable = true;

  nixpkgs.config.allowUnfree = true;
}
