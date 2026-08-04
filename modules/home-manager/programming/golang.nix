{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  options,
  parent-name,
  ...
}:
let
  module = {
    module-name = "golang";
    label = "Golang";
    config = {
      home.packages =
        with pkgs-unstable;
        [
          go
          sqlc
          goose
          air
          gopls
          gotools
          golangci-lint
        ]
        ++ [ (lib.hiPrio pkgs.gcc) ];
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
