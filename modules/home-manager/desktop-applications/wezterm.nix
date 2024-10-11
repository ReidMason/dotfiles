{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "wezterm";
  label = "Wezterm";
  config = {
    home.packages = [
      pkgs.wezterm
    ];

    home.file = {
      ".config/wezterm" = {
        source = ../../../configs/wezterm;
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
