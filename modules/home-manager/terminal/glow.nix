{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "glow";
    label = "Glow";
    config = {
      home.packages = [
        pkgs.glow
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
} 