{
  config,
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
  golang.enable = true;
  node.enable = true;
  gh.enable = true;
  terraform.enable = true;
  dotnet.enable = true;
  python.enable = true;

  programs.git.settings = {
    core.autocrlf = "input";
    user.email = lib.mkForce "reid.mason@smartcurrencyexchange.com";
  };

  programs.tmux-sessions.projectDirectories = [
    "/home/nixos/repos"
  ];

  dotfilesDir = "${config.home.homeDirectory}/repos";

  nixpkgs.config.allowUnfree = true;
}
