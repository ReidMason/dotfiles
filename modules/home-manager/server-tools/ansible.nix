{ pkgs, lib, config, ... }: {
  options = {
    ansible.enable = lib.mkEnableOption "Enable ansible";
  };

  config = lib.mkIf config.ansible.enable {
    home.packages = [
      pkgs.ansible
    ];
  };
}
