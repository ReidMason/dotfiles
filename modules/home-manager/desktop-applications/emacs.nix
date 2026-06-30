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
    (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      # Stable Spotlight launcher so macOS privacy prompts don't reset each rebuild.
      home.file."Applications/Emacs.app/Contents/MacOS/Emacs" = {
        executable = true;
        text = ''
          #!/bin/sh
          exec "${config.home.homeDirectory}/.nix-profile/bin/emacs" "$@"
        '';
      };

      home.file."Applications/Emacs.app/Contents/Info.plist".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>CFBundleExecutable</key>
          <string>Emacs</string>
          <key>CFBundleIdentifier</key>
          <string>com.reid.emacs</string>
          <key>CFBundleName</key>
          <string>Emacs</string>
          <key>CFBundlePackageType</key>
          <string>APPL</string>
        </dict>
        </plist>
      '';
    })
  ]);
}
