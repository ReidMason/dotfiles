{ pkgs, lib, ... }: {
  imports = [
    ./terminal/zsh.nix
    ./terminal/tmux-sessionizer.nix
    ./terminal
    ./server-tools
    ./desktop-environments

    ./programming/programming.nix
    ./desktop-applications
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

    zsh.autoAttachToTmux = lib.mkDefault false;

    tmux-sessionizer.enable = lib.mkDefault false;
  };
}
