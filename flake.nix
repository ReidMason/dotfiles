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
    home-config-builder = {host, system}: import ./modules/utils/home-config-builder.nix { inherit nixpkgs nixpkgs-unstable host system home-manager; };
  in
  {
    darwinConfigurations = {
      macos = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/macos/configuration.nix
        ];
        specialArgs = {
          inherit nixpkgs;
          inherit self;
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          pkgs-unstable = nixpkgs-unstable.legacyPackages.aarch64-darwin;
        };
      };
    };

    nixosConfigurations = {
      linux = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/linux/configuration.nix
        ];
      };

      old-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/old-laptop/configuration.nix
        ];
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
