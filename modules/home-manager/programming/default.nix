{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  options,
  ...
}:
let
  module-name = "programming";
  mkModule = path: import path { inherit pkgs pkgs-unstable lib config options; parent-name = module-name; };
in
{
  imports = map mkModule [
    ./python.nix
    ./git.nix
    ./haskell.nix
    ./node.nix
    ./dotnet.nix
    ./golang.nix
    ./lazygit.nix
    ./rust.nix
    ./bruno.nix
    ./nix.nix
    ./yaml.nix
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all programming tools";
  };
}
