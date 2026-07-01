{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.emacs;
  doomDir = "${config.home.homeDirectory}/.config/doom";
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

    home.file.".config/doom".source = ../../../configs/doom;

    home.sessionVariables = {
      DOOMDIR = doomDir;
    };

    home.sessionPath = [ "${config.home.homeDirectory}/.emacs.d/bin" ];

    # First-time: `just doom-setup`. Deploy config: home-manager switch. After init.el/packages.el: `just doom-sync`.
  };
}
