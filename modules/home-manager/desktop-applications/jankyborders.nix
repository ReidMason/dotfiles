{ config, lib, parent-name, ... }:
let
  theme = import ../theme.nix;
  module = {
    module-name = "jankyborders";
    label = "JankyBorders";
    config = {
      services.jankyborders = {
        enable = true;
        settings = {
          width = theme.borderWidth;
          hidpi = "on";
          active_color = "0xffcba6f7"; # Catppuccin Mocha Mauve
          inactive_color = "0xff6c7086"; # Catppuccin Mocha Overlay0
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
