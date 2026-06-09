{
  config,
  lib,
  parent-name,
  ...
}:
let
  module = {
    module-name = "television";
    label = "Television";
    config = {
      programs.tmux-sessions.enable = lib.mkDefault true;

      programs.television = {
        enable = true;
        enableZshIntegration = true;
        channels = {
          sesh = {
            metadata = {
              name = "sesh";
              description = "Session manager integrating tmux sessions, zoxide directories, and config paths";
              requirements = [ ];
            };
            source = {
              command = [
                "tmux-sessions list"
              ];
              ansi = true;
              output = "{strip_ansi|split: :1..|join: }";
              # Keep sesh sessions above tmux-sessions repos (source order).
              frecency = false;
              no_sort = true;
            };
            preview = {
              command = "tmux-sessions preview '{strip_ansi|split: :1..|join: }'";
            };
            keybindings = {
              enter = "actions:connect";
              ctrl-d = [
                "actions:kill_session"
                "reload_source"
              ];
            };
            actions = {
              connect = {
                description = "Connect to selected session";
                command = "tmux-sessions connect '{strip_ansi|split: :1..|join: }'";
                mode = "execute";
              };
              kill_session = {
                description = "Kill selected tmux session (press Ctrl+r to reload)";
                command = "tmux kill-session -t '{strip_ansi|split: :1..|join: }'";
                mode = "fork";
              };
            };
          };
        };
      };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix {
      inherit
        config
        lib
        parent-name
        module
        ;
    })
  ];
}
