default:
  @just --list

# ── Doom / Emacs ──────────────────────────────────────────────────────────────

[group('doom')]
doom-setup:
  #!/usr/bin/env bash
  set -euo pipefail
  if [ ! -f "$HOME/.emacs.d/bin/doom" ]; then
    git clone https://github.com/doomemacs/doomemacs.git "$HOME/.emacs.d"
  fi
  just doom-install

[group('doom')]
doom-install:
  EMACS="$(command -v emacs)" ~/.emacs.d/bin/doom install --force

[group('doom')]
doom-sync:
  EMACS="$(command -v emacs)" ~/.emacs.d/bin/doom sync

# ── Deploy ────────────────────────────────────────────────────────────────────

[group('deploy')]
home $host:
  git add .
  home-manager switch --flake .#$host

[group('deploy')]
nixos $host:
  git add .
  sudo nixos-rebuild switch --flake .#$host

[group('deploy')]
darwin $host:
  git add .
  sudo nix run nix-darwin -- switch --flake .#$host

# ── Nix maintenance ───────────────────────────────────────────────────────────

# Trigger an immediate NixOS upgrade from GitHub on the current machine
[group('nix')]
upgrade:
  systemctl start nixos-upgrade.service

[group('nix')]
update-flake:
  nix flake update

[group('nix')]
nix-gc:
  sudo nix-collect-garbage -d

# ── System ────────────────────────────────────────────────────────────────────

[group('system')]
restart-bluetooth:
  sudo pkill bluetoothd
