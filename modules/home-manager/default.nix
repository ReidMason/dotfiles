{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./terminal
    ./server-tools
    ./desktop-environments
    ./programming
    ./desktop-applications
  ];

  options.dotfilesDir = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/dotfiles";
    description = ''
      Absolute path to the local dotfiles repo checkout on this machine.
      Used to symlink configs (e.g. Neovim) directly to the repo instead of
      copying them into the Nix store, so files like lazy-lock.json stay
      writable. Override per-host if the checkout lives elsewhere.
    '';
  };

  config = {
    # Add nerd fonts to the system 
    fonts.fontconfig.enable = true;
    home.packages = [
      pkgs.nerd-fonts.jetbrains-mono
    ];
  };
}
