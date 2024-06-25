{ pkgs, lib, ... }: {
  imports = [
    ./programs/neofetch.nix
  ];

  neofetch.enable = lib.mkDefault true;
}
