{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "lazygit";
    label = "Lazygit";
    config = {
      home.packages = with pkgs; [
        pkgs.lazygit
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
