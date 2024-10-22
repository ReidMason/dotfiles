{ config, pkgs, lib, ... }:
let
name = "mona";
in {
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = name;
    networkManager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command"  "flakes" ];

  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Docker setup
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_27;
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  users.users."${name}" = {
    isNormalUser = true;
    extraGroups = [ "networkManager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = let
      authorizedKeys = pkgs.fetchurl {
        url = "https://github.com/reidmason.keys";
        hash = "sha256-HRI/UIplTM/xcYZY4NWJ22ETlcAHIodWKeAiLXXQC1M=";
      };
    in pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
  };

  # Allow sudo without password
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # settings = {
    #   PasswordAuthentication = false;
    # };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}
