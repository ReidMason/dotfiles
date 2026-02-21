# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  mainUser = "reid";
  appdataPath = "${config.users.users.${mainUser}.home}/appdata";
in
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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.reid = {
    isNormalUser = true;
    description = "reid";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys =
      let
        authorizedKeys = pkgs.fetchurl {
          url = "https://github.com/reidmason.keys";
          hash = "sha256-GAiShmhPpqrvN1rZrqxo3HRsu4s/8GsiqgzjszURQak=";
        };
      in
      pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Allow sudo without password
  security.sudo.wheelNeedsPassword = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Docker setup
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_27;
  };

  systemd.tmpfiles.rules = [
    "d ${appdataPath} 0755 ${mainUser} users -"
    "Z ${appdataPath} - ${mainUser} users -"

    "d ${appdataPath}/uptime-kuma 0755 ${mainUser} users -"

    "d ${appdataPath}/traefik 0755 ${mainUser} users -"
    "f ${appdataPath}/traefik/acme.json 0600 ${mainUser} users -"
  ];

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      uptime-kuma = {
        image = "louislam/uptime-kuma:2.1.1";
        volumes = [
          "${appdataPath}/uptime-kuma:/app/data"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.uptime-kuma.rule" = "Host(\`uptime-kuma.dev.reidmason.com\`)";
          "traefik.http.services.uptime-kuma.loadbalancer.server.port" = "3001";
          "traefik.http.routers.uptime-kuma.entrypoints" = "websecure";
          "traefik.http.routers.uptime-kuma.tls" = "true";
          # WebSocket support
          "traefik.http.middlewares.uptime-kuma-headers.headers.customrequestheaders.X-Forwarded-Proto" = "https";
          "traefik.http.routers.uptime-kuma.middlewares" = "uptime-kuma-headers";
        };
      };

      traefik = {
        image = "traefik:v3.6";
        ports = [
          "80:80"
          "443:443"
        ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "${appdataPath}/traefik:/data"
        ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.traefik-dashboard.rule" = "Host(\`traefik.dev.reidmason.com\`)";
          "traefik.http.routers.traefik-dashboard.service" = "api@internal";
          "traefik.http.routers.traefik-dashboard.entrypoints" = "websecure";
          "traefik.http.routers.traefik-dashboard.tls.certresolver" = "certresolver";
          "traefik.http.routers.traefik-dashboard.tls.domains[0].main" = "dev.reidmason.com";
          "traefik.http.routers.traefik-dashboard.tls.domains[0].sans" = "*.dev.reidmason.com";
        };
        environmentFiles = [ "/home/reid/secrets/traefik.env" ];
        cmd = [
          "--api.dashboard=true"
          "--providers.docker=true"
          "--entrypoints.web.address=:80"
          "--entrypoints.websecure.address=:443"
          "--certificatesresolvers.certresolver.acme.email=maddogshain132@gmail.com"
          "--certificatesresolvers.certresolver.acme.storage=/data/acme.json"
          "--certificatesresolvers.certresolver.acme.dnschallenge=true"
          "--certificatesresolvers.certresolver.acme.dnschallenge.provider=cloudflare"
          "--entrypoints.web.http.redirections.entrypoint.to=websecure"
          "--entrypoints.web.http.redirections.entrypoint.scheme=https"
        ];
      };
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}