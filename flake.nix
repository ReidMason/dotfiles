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
    home-manager-config = {
      allowUnfree = true;
    };
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
    };

    homeConfigurations = {
      macos = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config = home-manager-config;
        };
        extraSpecialArgs = {
          pkgs-unstable = nixpkgs-unstable.legacyPackages.aarch64-darwin;
        };
        modules = [ 
          ./hosts/macos/home.nix
          ./modules/home-manager
        ];
      };
      
      linux = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = home-manager-config;
        };
        extraSpecialArgs = {
          pkgs-unstable = nixpkgs-unstable.legacyPackages.aarch64-darwin;
        };
        modules = [ 
          ./hosts/linux/home.nix
          ./modules/home-manager
        ];
      };
    };
  };
}
