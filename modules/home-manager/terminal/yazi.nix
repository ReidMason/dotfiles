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
    module-name = "yazi";
    label = "Yazi";
    config = {
      home.packages = [
        pkgs.yazi
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
