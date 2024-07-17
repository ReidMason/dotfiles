{ pkgs, lib, config, ... }: {
  options = {
    terraform.enable = lib.mkEnableOption "Enable terraform";
  };

  config = lib.mkIf config.terraform.enable {
    home.packages = [
      pkgs.terraform
    ];
  };
}
