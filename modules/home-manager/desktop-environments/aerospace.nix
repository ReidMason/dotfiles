{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  options,
  parent-name,
  ...
}:
let
  module = {
    module-name = "aerospace";
    label = "Aerospace";
    config = {
      programs.aerospace = {
        enable = true;
        package = pkgs-unstable.aerospace;

        launchd.enable = true;

        settings = {
          default-root-container-layout = "tiles";
          default-root-container-orientation = "auto";

          gaps = {
            inner.horizontal = 5;
            inner.vertical = 5;
            outer.left = 3;
            outer.bottom = 3;
            outer.top = 3;
            outer.right = 3;
          };

          workspace-to-monitor-force-assignment = {
            "terminal" = "main";
            "browser" = "secondary";
          };

          on-window-detected = [
            {
              "if" = {
                app-id = "company.thebrowser.Browser";
              };
              run = "move-node-to-workspace browser";
            }
          ];

          mode.main.binding = {
            alt-slash = "layout tiles horizontal vertical";
            alt-comma = "layout accordion horizontal vertical";

            alt-f = "fullscreen";

            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";

            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            alt-minus = "resize smart -50";
            alt-shift-equal = "resize smart +50";

            alt-y = "workspace 1";
            alt-u = "workspace terminal";
            alt-i = "workspace browser";
            alt-o = "workspace 4";
            alt-p = "workspace misc";

            alt-shift-y = "move-node-to-workspace 1";
            alt-shift-u = "move-node-to-workspace terminal";
            alt-shift-i = "move-node-to-workspace browser";
            alt-shift-o = "move-node-to-workspace 4";
            alt-shift-p = "move-node-to-workspace misc";

            alt-tab = "workspace-back-and-forth";
            alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

            alt-shift-semicolon = "mode service";
          };

          mode.service.binding = {
            esc = [
              "reload-config"
              "mode main"
            ];
            r = [
              "flatten-workspace-tree"
              "mode main"
            ];
            f = [
              "layout floating tiling"
              "mode main"
            ];
            backspace = [
              "close-all-windows-but-current"
              "mode main"
            ];

            alt-shift-h = [
              "join-with left"
              "mode main"
            ];
            alt-shift-j = [
              "join-with down"
              "mode main"
            ];
            alt-shift-k = [
              "join-with up"
              "mode main"
            ];
            alt-shift-l = [
              "join-with right"
              "mode main"
            ];

            down = "volume down";
            up = "volume up";
            shift-down = [
              "volume set 0"
              "mode main"
            ];
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
