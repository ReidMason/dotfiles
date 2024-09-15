{ system, host, inputs }:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ../../hosts/${host}/configuration.nix
  ];
}

