{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "iperf";
    label = "Iperf";
    config = {
      home.packages = [
        pkgs.iperf
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
} 