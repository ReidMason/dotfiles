{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  options,
  ...
}:
let
  module-name = "server-tools";
  mkModule = path: import path { inherit pkgs pkgs-unstable lib config options; parent-name = module-name; };
in
{
  imports = map mkModule [
    ./helm.nix
    ./ansible.nix
    ./terraform.nix
    ./hashicorp-vault.nix
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Server tools";
  };
}
