{ system, host, inputs }:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = import inputs.nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
  extraSpecialArgs = {
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  };
  modules = [ 
    ../../hosts/${host}/home.nix
    ../home-manager
  ];
}
