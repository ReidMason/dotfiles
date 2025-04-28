{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "just";
    label = "Just";
    config = {
      home.packages = [
        pkgs.just
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
} 