{ pkgs, config, lib, options, parent-name, ... }:
let
module-name = "bat";
in
{
  options.${parent-name}.${module-name}.enable = lib.mkEnableOption "Bat";

  config = lib.mkIf (config.${parent-name}.${module-name}.enable || config.${parent-name}.enable) {
    home.packages = with pkgs; [
      bat
    ];

    home.shellAliases ={
      cat = "bat";
    };
  };
}
