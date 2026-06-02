{
  pkgs,
  config,
  lib,
  parent-name,
  ...
}:
let
  module = {
    module-name = "claude-code";
    label = "Claude code";
    config = {
      home.packages = with pkgs; [
        claude-code
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
