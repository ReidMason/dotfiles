{ pkgs, lib, ... }: {
  imports = [
    ./programs/neofetch.nix
    ./programs/starship.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./programs/zoxide.nix
    ./programs/tmux.nix
    ./programs/wezterm.nix
    ./programs/tmux-sessionizer.nix
    ./programs/bat.nix
    ./programs/utils.nix

    ./programming/golang.nix
    ./programming/node.nix

    ./server-tools/ansible.nix
  ];

  neofetch.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  zoxide.enable = lib.mkDefault true;
  tmux.enable = lib.mkDefault true;
  wezterm.enable = lib.mkDefault true;
  tmux-sessionizer.enable = lib.mkDefault true;
  bat.enable = lib.mkDefault true;
  utils.enable = lib.mkDefault true;

  golang.enable = lib.mkDefault true;
  node.enable = lib.mkDefault true;

  ansible.enable = lib.mkDefault true;
}
