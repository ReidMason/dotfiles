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
    module-name = "rust";
    label = "Rust";
    config = {
      home.packages = with pkgs-unstable; [
        rustup
        cargo-tarpaulin
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
