{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "golang";
    label = "Golang";
    config = {

      home.packages = with pkgs; [
        go
        sqlc
        goose
        air
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
