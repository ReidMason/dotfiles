{ pkgs, pkgs-unstable, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "aerospace";
    label = "Aerospace";
    config = {
      home.packages = with pkgs-unstable; [
        aerospace
      ];

      home.file = {
        ".config/aerospace" = {
          source = ../../../configs/aerospace;
        };
      };

    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
