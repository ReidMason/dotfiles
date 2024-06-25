{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";

  home.stateVersion = "24.05";

  home.packages = [];

  zsh.autoAttachToTmux = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
