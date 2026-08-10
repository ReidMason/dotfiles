{ config, lib, parent-name, ... }:
let
  module = {
    module-name = "jankyborders";
    label = "JankyBorders";
    config = {
      services.jankyborders = {
        enable = true;
        settings = {
          style = "round";
          width = 6.0;
          hidpi = "off";
          active_color = "0xffe2e2e3";
          inactive_color = "0xff414550";
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
