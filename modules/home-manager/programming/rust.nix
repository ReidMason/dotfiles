{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "rust";
    label = "Rust";
    config = {
      home.packages = with pkgs; [
        pkgs.cargo
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
