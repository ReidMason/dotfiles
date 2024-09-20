{ config, pkgs, lib, ... }:
{
  home.username = "vera";
  home.homeDirectory = "/home/vera";
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [];

  terminal.enable = true;
  programming.git.enable = true;

  nixpkgs.config.allowUnfree = true;
}
