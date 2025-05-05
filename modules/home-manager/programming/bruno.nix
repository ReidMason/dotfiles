{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "bruno";
    label = "Bruno";
    config = {
      home.packages = with pkgs; [
        bruno
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
