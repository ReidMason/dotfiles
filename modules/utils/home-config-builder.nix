{ system, host, nixpkgs, nixpkgs-unstable, home-manager }:
home-manager.lib.homeManagerConfiguration {
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
  extraSpecialArgs = {
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  };
  modules = [ 
    ../../hosts/${host}/home.nix
    ../home-manager
  ];
}
