{
  pkgs,
  config,
  lib,
  parent-name,
  ...
}:
let
  module = {
    module-name = "cursor-cli";
    label = "Cursor CLI";
    config = {
      home.packages = [
        pkgs.cursor-cli
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
