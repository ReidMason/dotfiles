{ system, host, inputs, specialArgs ? { } }:
inputs.nixpkgs.lib.nixosSystem {
  inherit system specialArgs;
  modules = [
    ../../hosts/${host}/configuration.nix
  ];
}

