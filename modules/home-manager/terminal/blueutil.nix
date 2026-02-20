# Bluetooth cli for Macos
{
  pkgs,
  config,
  lib,
  options,
  parent-name,
  ...
}:
let
  module = {
    module-name = "blueutil";
    label = "Blueutil";
    config = {
      home.packages = with pkgs; [
        blueutil
      ];
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
