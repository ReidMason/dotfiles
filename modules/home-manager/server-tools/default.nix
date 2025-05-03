{ pkgs, pkgs-unstable, lib, config, options, ... }:
let
  module-name = "server-tools";
in
{
  imports = [
    (import ./helm.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./ansible.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./terraform.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./hashicorp-vault.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Server tools";
  };
}
