{ pkgs, lib, config, ... }: {
  options = {
    node.enable = lib.mkEnableOption "Enable node";
  };

  config = lib.mkIf config.node.enable {
    home.packages = [
      pkgs.nodejs # This is the LTS version
      pkgs.pnpm
    ];
  };
}
