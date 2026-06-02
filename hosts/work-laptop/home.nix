{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.packages = [ ];

  terminal.enable = true;
  zsh.autoAttachToTmux = true;
  git.enable = true;

  nixpkgs.config.allowUnfree = true;
}
