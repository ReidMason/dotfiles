{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "talosctl";
    label = "Talosctl";
    config = {
      home.packages = [
        pkgs.talosctl
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
} 