{ pkgs, pkgs-unstable, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "dotnet";
    label = "Dotnet";
    config = {
      home.packages = with pkgs-unstable; [
        dotnet-sdk
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
