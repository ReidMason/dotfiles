{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.eza
    pkgs.git
    pkgs.lazygit
    pkgs.wezterm
  ];

  home.file = {
    ".config/wezterm" = {
      source = ../../../.config/wezterm;
    };
  };

  programs.zoxide.enable = true;

  programs.git = {
    enable = true;
    userName = "Reid Mason";
    userEmail = "maddogshain132@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
