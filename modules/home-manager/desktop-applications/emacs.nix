{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.emacs;
in
{
  options.emacs.enable = lib.mkEnableOption "Emacs (Doom via nix-doom-emacs-unstraightened)";

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = [
        pkgs.fd
      ];

      programs.doom-emacs = {
        enable = true;
        doomDir = ../../../configs/doom;
        doomLocalDir = "${config.home.homeDirectory}/.local/share/nix-doom";
        experimentalFetchTree = true;
      };
    }
  ]);
}
