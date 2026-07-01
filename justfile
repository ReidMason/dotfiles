# Show grouped list of available recipes
default:
  @just --list

# ── Doom / Emacs ──────────────────────────────────────────────────────────────

# Clone doomemacs if missing, then run doom-install
[group('doom')]
doom-setup:
  #!/usr/bin/env bash
  set -euo pipefail
  if [ ! -f "$HOME/.emacs.d/bin/doom" ]; then
    git clone https://github.com/doomemacs/doomemacs.git "$HOME/.emacs.d"
  fi
  just doom-install

# Install Doom Emacs using config from $DOOMDIR (~/.config/doom)
[group('doom')]
doom-install:
  #!/usr/bin/env bash
  set -euo pipefail
  export DOOMDIR="${HOME}/.config/doom"
  EMACS="$(command -v emacs)" "$HOME/.emacs.d/bin/doom" install --force

# Sync Doom packages and config after changing modules or packages.el
[group('doom')]
doom-sync:
  #!/usr/bin/env bash
  set -euo pipefail
  export DOOMDIR="${HOME}/.config/doom"
  EMACS="$(command -v emacs)" "$HOME/.emacs.d/bin/doom" sync

# ── Deploy ────────────────────────────────────────────────────────────────────

# Stage dotfiles and switch home-manager config for a flake host
[group('deploy')]
home $host:
  git add .
  home-manager switch --flake .#$host

# Stage dotfiles and rebuild NixOS for a flake host
[group('deploy')]
nixos $host:
  git add .
  sudo nixos-rebuild switch --flake .#$host

# Stage dotfiles and switch nix-darwin for a flake host
[group('deploy')]
darwin $host:
  git add .
  sudo nix run nix-darwin -- switch --flake .#$host

# ── Nix maintenance ───────────────────────────────────────────────────────────

# Trigger an immediate NixOS upgrade from GitHub on the current machine
[group('nix')]
upgrade:
  systemctl start nixos-upgrade.service

# Bump all flake lockfile inputs to their latest versions
[group('nix')]
update-flake:
  nix flake update

# Delete unused Nix store paths to free disk space
[group('nix')]
nix-gc:
  sudo nix-collect-garbage -d

# ── System ────────────────────────────────────────────────────────────────────

# Restart bluetoothd when Bluetooth stops responding
[group('system')]
restart-bluetooth:
  sudo pkill bluetoothd
