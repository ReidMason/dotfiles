{ pkgs, lib, ... }: {
  imports = [
    ./terminal/zsh.nix
    ./terminal/wezterm.nix
    ./terminal/tmux-sessionizer.nix
    ./terminal
    ./server-tools

    ./programming/programming.nix
    ./desktop-applications/desktop-applications.nix
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

    wezterm.enable = lib.mkDefault false;
    tmux-sessionizer.enable = lib.mkDefault false;
  };
}
