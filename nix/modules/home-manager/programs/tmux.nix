{ pkgs, lib, config, ... }: {
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.tmux.enable {
    home.packages = [
      pkgs.tmux
    ];

    home.file = {
      ".config/tmux" = {
        source = ../../../../tmux;
      };
    };
  };
}
