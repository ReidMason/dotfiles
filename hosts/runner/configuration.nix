{ config, pkgs, lib, ... }:

{
  imports = [ ./disk.nix ];

  # Proxmox VM bootloader — EFI with GRUB installed to removable path
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
      efi.canTouchEfiVariables = false;
    };
    initrd.availableKernelModules = [ "virtio_scsi" "virtio_pci" "virtio_blk" "xhci_pci" ];
  };

  services.qemuGuest.enable = true;

  networking = {
    hostName = "github-runner";
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/London";

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  # Fetch SSH keys from GitHub — update hash if keys change with:
  # nix-prefetch-url https://github.com/reidmason.keys
  users.users.root.openssh.authorizedKeys.keys =
    let
      authorizedKeys = pkgs.fetchurl {
        url = "https://github.com/reidmason.keys";
        hash = "sha256-GAiShmhPpqrvN1rZrqxo3HRsu4s/8GsiqgzjszURQak=";
      };
    in
    pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # Token file is placed on first deploy via nixos-anywhere --extra-files
  # Path: /var/lib/secrets/github-runner-token
  services.github-runners.prod = {
    enable = true;
    url = "https://github.com/reidmason/homelab";
    tokenFile = "/var/lib/secrets/github-runner-token";
    extraLabels = [ "self-hosted" "prod" "linux" ];
    extraPackages = with pkgs; [ docker git ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/secrets 0700 root root -"
  ];

  environment.systemPackages = with pkgs; [ git curl jq ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
