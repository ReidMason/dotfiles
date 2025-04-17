{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "dust";
    label = "Dust";
    config = {
      home.packages = [
        pkgs.dust
      ];
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
