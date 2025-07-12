# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "vera"; # Define your hostname.
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
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Mount nfs shares
  fileSystems = {
    "/mnt/fern/plex" = {
      device = "fern.lan:/mnt/user/Plex";
      fsType = "nfs";
    };

    "/mnt/fern/downloads" = {
      device = "fern.lan:/mnt/user/Downloads";
      fsType = "nfs";
    };

    "/home/vera/export/appdata" = {
      device = "/home/vera/appdata";
      options = [ "bind" ];
    };
  };

  # Configure NFS server
  services.nfs.server = {
    enable = true;
    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
    exports = "/home/vera/export/appdata fern.lan(sec=sys,ro,no_root_squash)";
  };

  # Docker setup
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_27;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      portainer-agent = {
        image = "portainer/agent:2.30.1-alpine";
        ports = [ "9001:9001" ];
        volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
        autoStart = true;
      };

      tailscale = {
        image = "tailscale/tailscale:v1.84.0";
        hostname = "Vera";
        environment = {
          TS_STATE_DIR = "/var/lib/tailscale";
          TS_USERSPACE = "false";
          TS_ROUTES = "10.128.0.0/24";
        };
        volumes = [
          "/home/vera/appdata/tailscale:/var/lib/tailscale"
          "/dev/net/tun:/dev/net/tun"
        ];
        capabilities = {
          net_admin = true;
          sys_module = true;
        };
        autoStart = true;
      };

      qbittorrent = {
        image = "binhex/arch-qbittorrentvpn:5.1.0-1-01";
        ports = [
          "6881:6881"
          "6881:6881/udp"
          "8118:8118"
          "8080:8080" # Webui
          "9117:9117" # Jackett port
          "8989:8989" # Sonarr port
          "7878:7878" # Radarr port
          "8191:8191" # Flaresolverr port
        ];
        volumes = [
          "/home/vera/appdata/qbittorrent:/config"
          "/mnt/fern/downloads/qBittorrent:/downloads"
          "/etc/localtime:/etc/localtime:ro"
        ];
        environmentFiles = [
          "/home/vera/secrets/downloads/qbittorrent.env"
        ];
        environment = {
          VPN_ENABLED = "yes";
          # VPN_USER = ""; In secrets env file
          # VPN_PASS = ""; In secrets env file
          VPN_PROV = "pia";
          VPN_CLIENT = "openvpn";
          STRICT_PORT_FORWARD = "no";
          ENABLE_PRIVOXY = "yes";
          WEBUI_PORT = "8080";
          LAN_NETWORK = "10.128.0.0/24";
          NAME_SERVERS = "209.222.18.222,84.200.69.80,37.235.1.174,1.1.1.1,209.222.18.218,37.235.1.177,84.200.70.40,1.0.0.1";
          VPN_INPUT_PORTS = "9117,8989,7878";
          VPN_OUTPUT_PORTS = "9117,8989,7878";
          UMASK = "000";
          PUID = "99";
          PGID = "100";
        };
        capabilities = {
          net_admin = true;
        };
      };

      jackett = {
        image = "linuxserver/jackett:0.22.1987";
        volumes = [
          "/home/vera/appdata/jackett:/config"
          "/etc/localtime:/etc/localtime:ro"
        ];
        environment = {
          PUID = "99";
          PGID = "100";
        };
        dependsOn = [ "qbittorrent" ];
        networks = [ "container:qbittorrent" ];
      };

      sonarr = {
        image = "linuxserver/sonarr:4.0.14";
        volumes = [
          "/home/vera/appdata/sonarr:/config"
          "/mnt/fern/downloads/qBittorrent/Completed:/downloads"
          "/mnt/fern/plex:/tv"
          "/dev/rtc:/dev/rtc"
          "/etc/localtime:/etc/localtime:ro"
        ];
        environment = {
          PUID = "99";
          PGID = "100";
        };
        dependsOn = [ "qbittorrent" ];
        networks = [ "container:qbittorrent" ];
      };

      radarr = {
        image = "binhex/arch-radarr:5.25";
        volumes = [
          "/home/vera/appdata/radarr:/config"
          "/mnt/fern/downloads/qBittorrent:/data"
          "/mnt/fern/plex:/media"
        ];
        environment = {
          PUID = "99";
          PGID = "100";
          UMASK = "000";
        };
        dependsOn = [ "qbittorrent" ];
        networks = [ "container:qbittorrent" ];
      };

      flaresolverr = {
        image = "ghcr.io/thephaseless/byparr:latest";
        dependsOn = [ "qbittorrent" ];
        networks = [ "container:qbittorrent" ];
      };

      uptime-kuma = {
        image = "louislam/uptime-kuma:1.23.16";
        volumes = [
          "/home/vera/appdata/uptime-kuma:/app/data"
        ];
        ports = [
          "3001:3001"
        ];
      };

      plex-media-server = {
        image = "plexinc/pms-docker:1.41.8.9834-071366d65";
        ports = [
          "32400:32400/tcp"
          "3005:3005/tcp"
          "8324:8324/tcp"
          "32469:32469/tcp"
          "1900:1900/udp"
          "32410:32410/udp"
          "32412:32412/udp"
          "32413:32413/udp"
          "32414:32414/udp"
        ];
        volumes = [
          "/home/vera/appdata/plex-media-server:/config"
          "/tmp/:/transcode"
          "/mnt/fern/plex:/data"
        ];
        environment = {
          VERSION = "docker";
          TZ = "Europe/London";
          UMASK = "000";
          PLEX_UID = "1000";
          ALLOWED_NETWORKS = "10.128.0.0/24";
        };
        extraOptions = [
          "--hostname=vera"
        ];
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vera = {
    isNormalUser = true;
    description = "vera";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys =
      let
        authorizedKeys = pkgs.fetchurl {
          url = "https://github.com/reidmason.keys";
          hash = "sha256-HRI/UIplTM/xcYZY4NWJ22ETlcAHIodWKeAiLXXQC1M=";
        };
      in
      pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
  };

  # Allow sudo without password
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
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
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      111
      2049
      4000
      4001
      4002
      20048
    ];
    allowedUDPPorts = [
      111
      2049
      4000
      4001
      4002
      20048
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
