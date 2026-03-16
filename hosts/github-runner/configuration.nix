{ pkgs, env, ... }:

{
  services.qemuGuest.enable = true;

  networking = {
    hostName = "github-runner-${env}";
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  # Token file must exist before deploying: /var/lib/secrets/github-runner-token
  services.github-runners."${env}" = {
    enable = true;
    url = "https://github.com/reidmason/homelab";
    tokenFile = "/var/lib/secrets/github-runner-token";
    extraLabels = [
      "self-hosted"
      env
      "linux"
    ];
    extraPackages = with pkgs; [
      docker
      git
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/secrets 0700 root root -"
    "f /var/lib/secrets/github-runner-token 0600 root root -"
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
    jq
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
