{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.emacs;
  doomDir = "${config.home.homeDirectory}/.config/doom";
  doomConfig = toString ../../../configs/doom;
in
{
  options.emacs.enable = lib.mkEnableOption "Emacs with Doom (config managed like Neovim)";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.emacs
      pkgs.fd
      pkgs.ripgrep
      pkgs.git
    ];

    # Live symlink into the repo — edit configs/doom directly, no rebuild needed.
    home.file.".config/doom".source = config.lib.file.mkOutOfStoreSymlink doomConfig;

    home.sessionVariables = {
      DOOMDIR = doomDir;
    };

    home.sessionPath = [ "${config.home.homeDirectory}/.emacs.d/bin" ];

    # First-time: `just doom-setup`. After init.el/packages.el changes: `just doom-sync`.
  };
}
