{ system, host, inputs }:
inputs.nix-darwin.lib.darwinSystem {
  inherit system;
  modules = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../../hosts/${host}/configuration.nix
  ];
  specialArgs = {
    self = inputs.self;
    nixpkgs = inputs.nixpkgs;
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  };
}
