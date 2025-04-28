{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "neofetch";
    label = "Neofetch";
    config = {
      home.packages = [
        pkgs.neofetch
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
} 