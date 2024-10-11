{ config, pkgs, lib, ... }:
{
  home.username = "vera";
  home.homeDirectory = "/home/vera";
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [];

  python.enable = true;

  terminal.enable = true;
  git.enable = true;

  nixpkgs.config.allowUnfree = true;
}
