{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  options,
  ...
}:
let
  module-name = "desktop-environments";
  mkModule = path: import path { inherit pkgs pkgs-unstable lib config options; parent-name = module-name; };
in
{
  imports = map mkModule [
    ./hyprland.nix
    ./aerospace.nix
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all desktop environments";
  };
}
