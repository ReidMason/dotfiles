{ pkgs, lib, ... }: {
  imports = [
    ./terminal/zsh.nix
    ./terminal/tmux.nix
    ./terminal/wezterm.nix
    ./terminal/tmux-sessionizer.nix
    ./terminal

    ./programming/programming.nix
    ./desktop-applications/desktop-applications.nix

    ./server-tools/ansible.nix
    ./server-tools/terraform.nix
  ];

  config = {
    # Add nerd fonts to the system 
    fonts.fontconfig.enable = true;
    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    zsh.enable = lib.mkDefault true;

    programming.enable = lib.mkDefault false;
    desktop-applications.enable = lib.mkDefault false;
    terminal.enable = lib.mkDefault false;

    zsh.autoAttachToTmux = lib.mkDefault false;

    tmux.enable = lib.mkDefault false;
    wezterm.enable = lib.mkDefault false;
    tmux-sessionizer.enable = lib.mkDefault false;

    ansible.enable = lib.mkDefault false;
    terraform.enable = lib.mkDefault false;
  };
}
