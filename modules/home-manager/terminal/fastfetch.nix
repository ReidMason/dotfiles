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
    module-name = "fastfetch";
    label = "Fastfetch";
    config = {
      home.packages = [
        pkgs.fastfetch
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
