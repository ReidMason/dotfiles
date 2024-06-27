{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";

  home.stateVersion = "24.05";

  home.packages = [];

  # Enable packages
  zsh.autoAttachToTmux = true;
  programming.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  desktop-applications.enable = true;

  nixpkgs.config.allowUnfree = true;
}
