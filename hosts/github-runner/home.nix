{ ... }:
{
  home.username = "root";
  home.homeDirectory = "/root";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = [];

  terminal.enable = true;
  git.enable = true;

  nixpkgs.config.allowUnfree = true;
}
