{
  description = "Macos system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
  in
  {
    darwinConfigurations = {
      macos = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/macbook/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      macos = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config = {
            allowUnfree = true;
          };
        };
        modules = [ 
          ./home.nix
          ../../modules/home-manager
        ];
      };
    };
  };
}
# nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .
