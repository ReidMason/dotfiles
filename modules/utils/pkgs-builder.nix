{ system, host, nixpkgs, nixpkgs-unstable }: {
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
