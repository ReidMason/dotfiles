{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";

  home.stateVersion = "24.05";

  home.packages = [];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
