{
  description = "System configuration using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager }:
  let
    home-config-builder = {host, system}: import ./modules/utils/home-config-builder.nix { inherit nixpkgs nixpkgs-unstable home-manager host system; };
    nix-config-builder = {host, system}: import ./modules/utils/nix-config-builder.nix { inherit nixpkgs host system;};
    darwin-config-builder = {host, system}: import ./modules/utils/darwin-config-builder.nix { inherit self nixpkgs nixpkgs-unstable nix-darwin host system; };
  in
  {
    darwinConfigurations = {
      macos = darwin-config-builder {
        system = "aarch64-darwin";
        host = "macos";
      };
    };

    nixosConfigurations = {
      linux = nix-config-builder {
        system = "x86_64-linux";
        host = "linux";
      };

      old-laptop = nix-config-builder {
        system = "x86_64-linux";
        host = "old-laptop";
      };
    };

    homeConfigurations = {
      macos = home-config-builder { 
        host = "macos";
        system = "aarch64-darwin"; 
      };
      
      linux = home-config-builder { 
        host = "linux";
        system = "x86_64-linux";
      };

      old-laptop = home-config-builder { 
        host = "old-laptop";
        system = "x86_64-linux";
      };
    };
  };
}
