{ system, host, inputs }:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
  extraSpecialArgs = {
    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  };
  modules = [
    ../../hosts/${host}/home.nix
    ../home-manager
  ];
}
