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
    module-name = "docker";
    label = "Docker";
    config = {
      home.packages = [
        pkgs.docker-compose-language-service
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
