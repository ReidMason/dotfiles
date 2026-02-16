{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  home.username = "reid";
  home.homeDirectory = "/home/reid";

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [ ];

  python.enable = true;

  terminal.enable = true;
  git.enable = true;

  nixpkgs.config.allowUnfree = true;
}
