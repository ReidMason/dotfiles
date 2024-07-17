{ pkgs, lib, config, ... }: {
  options = {
    neofetch.enable = lib.mkEnableOption "Enable neofetch";
  };

  config = lib.mkIf config.neofetch.enable {
    home.packages = [
      pkgs.neofetch
    ];
  };
}
