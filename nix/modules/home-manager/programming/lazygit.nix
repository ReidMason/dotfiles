{ pkgs, lib, config, ... }: {
  options = {
    lazygit.enable = lib.mkEnableOption "Enable lazygit";
  };

  config = lib.mkIf config.lazygit.enable {
    home.packages = [
      pkgs.lazygit
    ];
  };
}
