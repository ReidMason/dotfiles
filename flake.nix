{
  description = "System configuration using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      disko,
    }:
    let
      utils = import ./modules/utils;
      home-config-builder = { host, system }: utils.home-config-builder { inherit inputs host system; };
      nix-config-builder = { host, system }: utils.nix-config-builder { inherit inputs host system; };
      darwin-config-builder =
        { host, system }: utils.darwin-config-builder { inherit inputs host system; };
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

        nix-playground = nix-config-builder {
          system = "x86_64-linux";
          host = "nix-playground";
        };

        vera = nix-config-builder {
          system = "x86_64-linux";
          host = "vera";
        };

        mona = nix-config-builder {
          system = "aarch64-linux";
          host = "mona";
        };

        nia = nix-config-builder {
          system = "x86_64-linux";
          host = "nia";
        };

        runner = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/runner/configuration.nix
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

        nix-playground = home-config-builder {
          host = "nix-playground";
          system = "x86_64-linux";
        };

        vera = home-config-builder {
          host = "vera";
          system = "x86_64-linux";
        };

        mona = home-config-builder {
          host = "mona";
          system = "aarch64-linux";
        };

        nia = home-config-builder {
          host = "nia";
          system = "x86_64-linux";
        };
      };
    };
}
