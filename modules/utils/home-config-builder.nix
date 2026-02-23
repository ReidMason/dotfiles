{ system, host, inputs }:
let
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = {
    inherit pkgs;
    pkgs-unstable = pkgs;
  };
  modules = [
    ../../hosts/${host}/home.nix
    ../home-manager
  ];
}
