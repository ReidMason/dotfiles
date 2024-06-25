{ pkgs, lib, ... }: {
  imports = [
    ./programs/neofetch.nix
    ./programs/starship.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./programs/zoxide.nix
    ./programs/wezterm.nix
  ];

  neofetch.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  zoxide.enable = lib.mkDefault true;
  wezterm.enable = lib.mkDefault true;
}
