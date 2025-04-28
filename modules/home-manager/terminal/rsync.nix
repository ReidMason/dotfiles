{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "rsync";
    label = "Rsync";
    config = {
      home.packages = [
        pkgs.rsync
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
} 