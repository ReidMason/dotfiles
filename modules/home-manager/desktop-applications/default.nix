{ pkgs, pkgs-unstable, lib, config, options, ... }:
let
  module-name = "desktop-applications";
in
{
  imports = [
    (import ./wezterm.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./firefox.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./ollama.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./obsidian.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./skhd.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all desktop applications";
  };
}
