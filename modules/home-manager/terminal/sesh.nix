{
  pkgs,
  config,
  lib,
  parent-name,
  ...
}:
let
  projects = [
    "dotfiles"
    "homelab"
    "plex-ani-sync"
  ];

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
          session = map (name: {
            inherit name;
            path = "~/Documents/repos/${name}";
          }) projects;
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
