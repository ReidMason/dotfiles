{
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

  programs.tmux-sessions.projectDirectories = [
    "/mnt/c/Documents/projects/Repos"
  ];

  nixpkgs.config.allowUnfree = true;
}
