{ pkgs, lib, config, ... }: {
  options = {
    bat.enable = lib.mkEnableOption "Enable bat";
  };

  config = lib.mkIf config.bat.enable {
    home.packages = [
      pkgs.bat
    ];

    home.shellAliases = {
      cat = "bat";
    };
  };
}
