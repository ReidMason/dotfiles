{ pkgs, pkgs-unstable, lib, config, options, ... }:
let
  module-name = "programming";
in
{
  imports = [
    (import ./python.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./git.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./haskell.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./node.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./dotnet.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./golang.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./lazygit.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./rust.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
  ];

  options.programming = {
    enable = lib.mkEnableOption "Enable all programming tools";
  };
}
