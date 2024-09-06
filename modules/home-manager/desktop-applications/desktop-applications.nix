{ pkgs, lib, config, ... }: {
  options.desktop-applications = {
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
