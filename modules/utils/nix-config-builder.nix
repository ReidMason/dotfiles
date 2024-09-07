{ system, host, nixpkgs }:
nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ../../hosts/${host}/configuration.nix
  ];
}

