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
    (lib.mkIf pkgs.stdenv.isDarwin {
      # Stable .app path so macOS remembers Documents access across rebuilds.
      home.file."Applications/Emacs.app" = {
        source = "${config.programs.doom-emacs.finalEmacsPackage}/Applications/Emacs.app";
        recursive = true;
      };

      # Shadow the nix-store emacs binary; launch via the stable .app instead.
      home.file.".local/bin/emacs" = {
        executable = true;
        text = ''
          #!${pkgs.runtimeShell}
          if [ "$#" -eq 0 ]; then
            exec open -a Emacs
          else
            exec open -a Emacs --args "$@"
          fi
        '';
      };
    })
  ]);
}
