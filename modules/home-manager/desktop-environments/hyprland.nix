{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "hyprland";
  label = "Hyprland";
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [
         "$mod, q, exec, wezterm"
        ];
        exec-once = [];
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
        };
        decoration = {
          rounding = 10;
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        input = {
          sensitivity = -0.5;
        };
      };
    };
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
