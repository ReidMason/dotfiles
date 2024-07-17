{ pkgs, lib, config, ... }: {
  options = {
    tmux-sessionizer.enable = lib.mkEnableOption "Enable tmux-sessionizer";
  };

  config = lib.mkIf config.tmux-sessionizer.enable {
    home.packages = [
      pkgs.tmux-sessionizer
    ];

    home.file = {
      ".config/tms" = {
        source = ../../../../tms;
      };
    };

    home.sessionVariables = {
      TMS_CONFIG_FILE = "\${HOME}/.config/tms/tms.toml";
    };

    programs.tmux = {
      extraConfig = ''
        # Session handing
        bind s display-popup -E "tms switch"
        bind f display-popup -E "tms"
      '';
    };
  };
}
