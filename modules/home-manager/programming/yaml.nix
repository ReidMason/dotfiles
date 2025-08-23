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
    module-name = "yaml";
    label = "YAML";
    config = {
      home.packages = with pkgs; [
        pkgs.yaml-language-server
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
