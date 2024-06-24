# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
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

  nix.settings.experimental-features = [ "nix-command"  "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.reid = {
    isNormalUser = true;
    description = "Reid Mason";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgPliRySp1AulAYaB3/Nz1fZEmc8WNDTu1cxuqa/e6yYk1e/LYI7i7UHwzn4JxgZhA26X8GMhXBFw7Nrv7vgcyeDoTl0nZogqbzWiWpe0ETJkGaF19jiBjDWQbIXFNxNmy1ZCeIzZ+QSn5G2Z4mTF7ePbWqcmA9NDFzX8nRGa9mRBnjbg2XIobClN05XLQa7YuaaLL77NmTYLMqKhP5VGrUTYCyNGAZhNKaa6GPVX+I9C8X9uNUyvMG2YVrc3QJzLZ7u85xdKXnyxizJxEIrABMYXLhmBHGoGAHQTt2fk6VscS0ZQedCHweT34hhuD4+sY5GYZES4bXICzpFfAWqSXn0uXoOSRgRKDe7ZfWYsMDxxfmCFCVwPmNnwOJRYn3bDAPcMiFrTTMTfefyOh2MpkWFVGWeHXxA5gkq0QmcySLHNG9ucZedKOLETtccHOb7i8UIJ6+uk0ZfWGtpyW/iOl54AtB457A9AJ8OjVB2O9w9pvQE1+AuHenZFOKvvJ6Ok= reid@Reids-MacBook-Pro.local"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    stow
    home-manager
    lazygit

    neovim
    ripgrep
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
