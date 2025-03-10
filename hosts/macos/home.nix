{ config, pkgs, lib, ... }:
{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [ ];

  # Enable packages
  zsh.autoAttachToTmux = true;
  programming.enable = true;

  desktop-applications.enable = true;

  firefox.enable = false;
  terminal.enable = true;
  server-tools.enable = true;

  tmux.enable = true;
  wezterm.enable = true;
  tmux-sessionizer.enable = true;

  terraform.enable = true;

  nixpkgs.config.allowUnfree = true;
}
