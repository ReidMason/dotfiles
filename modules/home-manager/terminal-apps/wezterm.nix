{ pkgs, lib, config, ... }: {
  options = {
    wezterm.enable = lib.mkEnableOption "Enable wezterm";
  };

  config = lib.mkIf config.wezterm.enable {
    home.packages = [
      pkgs.wezterm
    ];

    home.file = {
      ".config/wezterm" = {
        source = ../../../config/wezterm;
      };
    };
  };
}
