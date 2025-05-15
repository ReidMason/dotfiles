{ pkgs, lib, ... }: {
  imports = [
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
      # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
