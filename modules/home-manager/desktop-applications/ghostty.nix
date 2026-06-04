{
  pkgs,
  config,
  lib,
  parent-name,
  ...
}:
let
  module = {
    module-name = "ghostty";
    label = "Ghostty";
    config = {
      programs.ghostty = {
        enable = true;
        package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
        enableZshIntegration = true;
        settings = {
          theme = "Catppuccin Mocha";
          font-family = "JetBrainsMono Nerd Font";
          font-size = 18;
          window-padding-x = "4,4";
          window-padding-y = "4,0";
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
          macos-icon-frame = "plastic";
          # macos-window-buttons = "hidden";
          # macos-titlebar-style = "hidden";
        };
      };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix {
      inherit
        config
        lib
        parent-name
        module
        ;
    })
  ];
}
