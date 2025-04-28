{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "zoxide";
    label = "Zoxide";
    config = {
      home.packages = [
        pkgs.zoxide
      ];
      programs.zoxide.enable = true;
      home.shellAliases = {
        cd = "z";
      };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
} 