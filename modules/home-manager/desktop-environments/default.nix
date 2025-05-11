{ pkgs, pkgs-unstable, lib, config, options, ... }:
let
  module-name = "desktop-environments";
in
{
  imports = [
    (import ./hyprland.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./aerospace.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all desktop environments";
  };
}
