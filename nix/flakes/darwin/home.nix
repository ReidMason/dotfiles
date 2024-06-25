{ config, pkgs, ... }:

{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.zsh
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

  programs.zsh = {
    enable = true;
    shellAliases = {
      # Nix commands
      rebuild-system = "sudo nixos-rebuild switch --flake ~/Documents/repos/dotfiles/nix-darwin/";
      rebuild-home = "home-manager switch --flake ~/Documents/repos/dotfiles/nix-darwin/";

      # Eza aliases
      ls = "eza -lh --icons --no-user --group-directories-first";
      ll = "eza -lah --icons --no-user --no-time --group-directories-first";
      tree = "eza --tree --icons --no-user --no-time --group-directories-first";

      # General aliases
      cp = "cp -iv";
      cd = "z";
      ".." = "cd ..";
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
