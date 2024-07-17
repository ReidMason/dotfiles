{ pkgs, lib, config, ... }: {
  options = {
    zoxide.enable = lib.mkEnableOption "Enable zoxide";
  };

  config = lib.mkIf config.zoxide.enable {
    home.packages = [
      pkgs.zoxide
    ];
    programs.zoxide.enable = true;
    
    home.shellAliases = {
        cd = "z";
    };
  };
}

