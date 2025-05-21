{ pkgs, pkgs-unstable, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "skhd";
    label = "skhd";
    config = {
      home.packages = [
        pkgs.skhd
      ];

      home.file.".skhdrc".text = ''
        # These are binds set in the macos keybinds (System Settings > Accessibility > Keyboard Shortcuts > Windows > Halves)
        # You have to change these binds because by default they are "fn + ctrl + arrows"
        # That overlaps with page up/down, home and end because macos is dumb and you can't bind these in skhd
        # You can just go into the settings, change the binding then hit the skhd shortcut and it'll fill the binding for you
        alt - f : skhd -k "fn + ctrl - f"
        alt - h : skhd -k "alt + shift + ctrl - h"
        alt - j : skhd -k "alt + shift + ctrl - j"
        alt - k : skhd -k "alt + shift + ctrl - k"
        alt - l : skhd -k "alt + shift + ctrl - l"

        # Applications
        alt - b : open /Applications/Arc.app
        alt - t : open "${pkgs-unstable.wezterm}/Applications/WezTerm.app"
      '';
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
