{ pkgs, lib, ... }: {
  imports = [
    ./terminal-apps/starship.nix
    ./terminal-apps/zsh.nix
    ./terminal-apps/neovim.nix
    ./terminal-apps/tmux.nix
    ./terminal-apps/wezterm.nix
    ./terminal-apps/tmux-sessionizer.nix
    ./terminal-apps/terminal-apps.nix

    ./programming/programming.nix
    ./desktop-applications/desktop-applications.nix

    ./server-tools/ansible.nix
    ./server-tools/terraform.nix
  ];

  zsh.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;

  programming.enable = lib.mkDefault false;
  desktop-applications.enable = lib.mkDefault false;
  terminal-apps.enable = lib.mkDefault false;

  zsh.autoAttachToTmux = lib.mkDefault false;
  
  neovim.enable = lib.mkDefault false;
  tmux.enable = lib.mkDefault false;
  wezterm.enable = lib.mkDefault false;
  tmux-sessionizer.enable = lib.mkDefault false;

  ansible.enable = lib.mkDefault false;
  terraform.enable = lib.mkDefault false;
}
