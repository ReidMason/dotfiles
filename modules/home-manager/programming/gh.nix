{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "gh";
    label = "GitHub CLI";
    config = {
      home.packages = with pkgs; [
        pkgs.gh
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
