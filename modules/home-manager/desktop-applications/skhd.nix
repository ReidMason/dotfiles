{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "skhd";
    label = "skhd";
    config = {
      home.packages = [
        pkgs.skhd
      ];

      services.skhd.enable = true;
      # services.skhd.config = { };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
