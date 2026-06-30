{ config, lib, ... }:
{
  options.emacs.enable = lib.mkEnableOption "Emacs (Doom via nix-doom-emacs-unstraightened)";

  config = lib.mkIf config.emacs.enable {
    programs.doom-emacs = {
      enable = true;
      doomDir = ../../../configs/doom;
      doomLocalDir = "${config.home.homeDirectory}/.local/share/nix-doom";
      experimentalFetchTree = true;
    };
  };
}
