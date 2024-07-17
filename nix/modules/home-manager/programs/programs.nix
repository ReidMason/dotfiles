{ pkgs, lib, config, ... }: {
  options.programs = {
    enable = lib.mkEnableOption "Enable all programs";

    batcat.enable = lib.mkEnableOption "Enable bat";
  };

  config = {
    programs.batcat.enable = lib.mkDefault config.programs.enable;

    home.packages = lib.concatLists [
      (lib.optional config.programs.batcat.enable pkgs.bat)
    ];

    home.shellAliases = lib.mkIf config.programs.batcat.enable {
      cat = "bat";
    };
  };
}
