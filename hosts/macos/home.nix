{ config, ... }:
{
  home.username = "reid";
  home.homeDirectory = "/Users/reid";
  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable packages
  zsh.autoAttachToTmux = true;
  zsh.vaultPath = "${config.home.homeDirectory}/Documents/Knowledge Base";
  programming.enable = true;

  desktop-applications.enable = true;
  sketchybar.enable = false;
  ollama.enable = false;

  firefox.enable = false;
  terminal.enable = true;
  server-tools.enable = true;

  wezterm.enable = true;
  tmux.enable = true;

  skhd.enable = false;

  terraform.enable = true;

  programs.tmux-sessions.projectDirectories = [
    "${config.home.homeDirectory}/Documents/repos"
  ];

  dotfilesDir = "${config.home.homeDirectory}/Documents/repos/dotfiles";

  nixpkgs.config.allowUnfree = true;
}
