{
  pkgs,
  config,
  lib,
  parent-name,
  ...
}:
let
  module = {
    module-name = "sesh";
    label = "Sesh";
    config = {
      programs.sesh = {
        enable = true;
        enableTmuxIntegration = false;
        enableAlias = false;

        settings = {
          cache = false;
          dir_length = 1;
          wildcard = [
            { pattern = "~/Documents/repos/*"; }
          ];
        };
      };
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
