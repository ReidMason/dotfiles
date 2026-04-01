{
  description = "System configuration using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    tmux-sessions.url = "github:ReidMason/tmux-sessions";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
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
      tmux-sessions,
    }:
    let
      utils = import ./modules/utils;
      inherit (nixpkgs.lib) listToAttrs nameValuePair;

      home-config-builder = { host, system }: utils.home-config-builder { inherit inputs host system; };
      nix-config-builder = { host, system, specialArgs ? { } }: utils.nix-config-builder { inherit inputs host system specialArgs; };
      darwin-config-builder =
        { host, system }: utils.darwin-config-builder { inherit inputs host system; };

      # Flake attribute name → { system, host ? name, specialArgs ? {} }. One row per machine for both NixOS and home-manager.
      githubRunnerPkgs = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      mkGithubRunnerArgs = env: {
        inherit env;
        pkgs-unstable = githubRunnerPkgs;
      };

      linuxHosts = [
        { name = "linux"; system = "x86_64-linux"; }
        { name = "nix-playground"; system = "x86_64-linux"; }
        { name = "vera"; system = "x86_64-linux"; }
        { name = "mona"; system = "aarch64-linux"; }
        { name = "nia"; system = "x86_64-linux"; }
        {
          name = "github-runner-dev";
          host = "github-runner";
          system = "x86_64-linux";
          specialArgs = mkGithubRunnerArgs "dev";
        }
        {
          name = "github-runner-prod";
          host = "github-runner";
          system = "x86_64-linux";
          specialArgs = mkGithubRunnerArgs "prod";
        }
      ];

      homeHosts = [ { name = "macos"; system = "aarch64-darwin"; } ] ++ linuxHosts;
    in
    {
      darwinConfigurations = {
        macos = darwin-config-builder {
          system = "aarch64-darwin";
          host = "macos";
        };
      };

      nixosConfigurations = listToAttrs (
        map (m:
          nameValuePair m.name (
            nix-config-builder {
              host = m.host or m.name;
              inherit (m) system;
              specialArgs = m.specialArgs or { };
            }
          )) linuxHosts
      );

      homeConfigurations = listToAttrs (
        map (m:
          nameValuePair m.name (
            home-config-builder {
              host = m.host or m.name;
              inherit (m) system;
            }
          )) homeHosts
      );
    };
}
