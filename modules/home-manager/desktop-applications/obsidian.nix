{ pkgs, pkgs-unstable, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "obdidian";
    label = "Obsidian";
    config = {
      home.packages = [
        pkgs.obsidian
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
