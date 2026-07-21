{
  pkgs-unstable,
  config,
  lib,
  parent-name,
  ...
}:
let
  module = {
    module-name = "sketchybar";
    label = "Sketchybar";
    config = {
      programs.sketchybar = {
        enable = true;
        package = pkgs-unstable.sketchybar;
        config.text = ''
          sketchybar --bar position=top height=32 topmost=on \
            padding_left=10 padding_right=10 color=0xff181926

          sketchybar --default \
            icon.font="JetBrainsMono Nerd Font:Bold:14.0" \
            icon.color=0xffcad3f5 \
            label.font="JetBrainsMono Nerd Font:Bold:14.0" \
            label.color=0xffcad3f5

          sketchybar --add item clock right \
            --set clock script="date '+%H:%M'" update_freq=10

          sketchybar --update
        '';
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
