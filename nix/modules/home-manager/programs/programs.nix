{ pkgs, lib, config, ... }: {
  options.programs = {
    enable = lib.mkEnableOption "Enable all programs";

    bat.enable = lib.mkEnableOption "Enable bat";
  };

  config = {
    programs.bat.enable = lib.mkDefault config.programs.enable;

    home.packages = lib.concatLists [
      (lib.optional config.programs.bat.enable pkgs.bat)
    ];

    home.shellAliases = lib.mkIf config.programs.bat.enable {
      cat = "bat";
    };
  };
}
