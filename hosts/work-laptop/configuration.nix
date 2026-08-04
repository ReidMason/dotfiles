{
  config,
  lib,
  pkgs,
  nixosWsl,
  ...
}:
{
  imports = [
    nixosWsl.nixosModules.default
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.docker-desktop.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = "25.11";
}
