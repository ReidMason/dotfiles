{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.eza
    pkgs.git
    pkgs.lazygit
    pkgs.neovim
    pkgs.wezterm
  ];

  home.file = {
    ".config/nvim" = {
      source = ../../../.config/nvim;
    };
    ".config/wezterm" = {
      source = ../../../.config/wezterm;
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
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
