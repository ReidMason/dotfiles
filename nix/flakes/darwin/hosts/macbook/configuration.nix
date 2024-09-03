{pkgs, system, ...}:
let
  pkgs = nixpkgs.legacyPackages.${system};
in
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
  nixpkgs.hostPlatform = "${system}";

  # Declare the user that will be running `nix-darwin`.
  users.users.reid = {
    name = "reid";
    home = "/Users/reid";
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  environment.systemPackages = [ pkgs.home-manager ];
}
