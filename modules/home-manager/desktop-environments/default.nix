{ pkgs, pkgs-unstable, lib, config, options, ... }: 
let
module-name = "desktop-environments";
in
{
  imports = [
     (import ./hyprland.nix { inherit pkgs lib options config; parent-name = module-name; })
  ];
}
