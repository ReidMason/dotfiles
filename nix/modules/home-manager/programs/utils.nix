{ pkgs, lib, config, ... }: {
  options = {
    utils.enable = lib.mkEnableOption "Enable utils";
  };

  config = lib.mkIf config.utils.enable {
    home.packages = [
      pkgs.htop
      pkgs.glow
      pkgs.iperf
      pkgs.rsync
    ];
  };
}
