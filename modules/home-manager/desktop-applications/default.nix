{ pkgs, pkgs-unstable, lib, config, options, ... }: 
let
module-name = "desktop-applications";
in
{
  imports = [
     (import ./wezterm.nix { inherit pkgs lib options config; parent-name = module-name; })
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all desktop applications";

    obsidian.enable = lib.mkEnableOption "Enable Obsidian";
  };

  config = {
    desktop-applications.obsidian.enable = lib.mkDefault config.desktop-applications.enable;

    home.packages = lib.concatLists [
      (lib.optional config.desktop-applications.obsidian.enable pkgs.obsidian)
    ];
  };
}
