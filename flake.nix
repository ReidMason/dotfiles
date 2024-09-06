{
  description = "System configuration using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager, stylix }:
  let
    home-manager-config = {
      allowUnfree = true;
    };
    inherit (self) outputs;
  in
  {
    overlays = import ./modules/overlays { inherit inputs; };

    darwinConfigurations = {
      macos = nix-darwin.lib.darwinSystem {
        modules = [
          stylix.darwinModules.stylix
          ./hosts/macos/configuration.nix
        ];
        specialArgs = { inherit nixpkgs; inherit self; };
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
        extraSpecialArgs = { inherit outputs; };
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
        modules = [ 
          ./hosts/linux/home.nix
          ./modules/home-manager
        ];
      };
    };
  };
}
