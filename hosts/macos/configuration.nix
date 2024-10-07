{ self, nixpkgs, pkgs, pkgs-unstable, ... }:
{
  services.nix-daemon.enable = true;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility. please read the changelog
  # before changing: `darwin-rebuild changelog`.
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  # If you're on an Intel system, replace with "x86_64-darwin"
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Declare the user that will be running `nix-darwin`.
  users.users.reid = {
    name = "reid";
    home = "/Users/reid";
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
      "/System/Applications/Mail.app"
      "/Applications/Arc.app"
      "${pkgs.wezterm}/Applications/WezTerm.app"
    ];

    finder.AppleShowAllFiles = true;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    finder.AppleShowAllExtensions = true;
  };

  environment.systemPackages = [ pkgs.home-manager ];

  programs.zsh.enable = true;
}
