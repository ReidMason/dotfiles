{ pkgs, lib, ... }: {
  imports = [
    ./programs/neofetch.nix
    ./programs/starship.nix
  ];

  neofetch.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
}
