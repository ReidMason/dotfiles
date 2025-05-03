{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "tmux-sessionizer";
    label = "Tmux sessionizer";
    config = {
      home.packages = [
        pkgs.tmux-sessionizer
      ];

      home.file = {
        ".config/tms" = {
          source = ../../../configs/tms;
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
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
