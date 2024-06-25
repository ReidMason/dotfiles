{ pkgs, lib, config, ... }: {
  options = {
    git.enable = lib.mkEnableOption "Enable git";
  };

  config = lib.mkIf config.git.enable {
    home.packages = [
      pkgs.git
    ];

    programs.git = {
      enable = true;
      userName = "Reid Mason";
      userEmail = "maddogshain132@gmail.com";
    };
  };
}
