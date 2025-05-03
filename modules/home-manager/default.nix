{ pkgs, lib, ... }: {
  imports = [
    ./terminal/zsh.nix
    ./terminal/tmux-sessionizer.nix
    ./terminal
    ./server-tools
    ./desktop-environments
    ./programming
    ./desktop-applications
  ];

  config = {
    # Add nerd fonts to the system 
    fonts.fontconfig.enable = true;
    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    zsh.enable = lib.mkDefault true;
    zsh.autoAttachToTmux = lib.mkDefault false;
    tmux-sessionizer.enable = lib.mkDefault false;
  };
}
