{ pkgs, lib, config, ... }: {
  options = {
    docker.enable = lib.mkEnableOption "Enable docker";
  };

  config = lib.mkIf config.docker.enable {
    home.packages = [
      pkgs.docker
    ];
  };
}
