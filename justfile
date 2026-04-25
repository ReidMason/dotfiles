default:
  @just --list

home $host:
  git add .
  home-manager switch --flake .#$host

nixos $host:
  git add .
  sudo nixos-rebuild switch --flake .#$host

darwin $host:
  git add .
  nix run nix-darwin -- switch --flake .#$host

# Trigger an immediate NixOS upgrade from GitHub on the current machine
upgrade:
  systemctl start nixos-upgrade.service

update-flake:
  nix flake update

nix-gc:
  sudo nix-collect-garbage -d
