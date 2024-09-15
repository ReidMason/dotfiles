{ system, host, inputs }:
inputs.nix-darwin.lib.darwinSystem {
  inherit system;
  modules = [
    ../../hosts/${host}/configuration.nix
  ];
  specialArgs = {
    inherit "inputs.self" "inputs.nixpkgs";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  };
}
