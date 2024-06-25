{ pkgs, lib, config, ... }: {
  options = {
    golang.enable = lib.mkEnableOption "Enable golang";
  };

  config = lib.mkIf config.golang.enable {
    home.packages = [
      pkgs.go
    ];
  };
}
