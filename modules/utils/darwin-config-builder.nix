{ system, host, self, nixpkgs, nixpkgs-unstable, nix-darwin }:
nix-darwin.lib.darwinSystem {
  inherit system;
  modules = [
    ../../hosts/${host}/configuration.nix
  ];
  specialArgs = {
    inherit self nixpkgs;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  };
}
