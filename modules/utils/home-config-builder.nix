{ system, host, inputs }:
let
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = {
    inherit inputs pkgs;
    pkgs-unstable = pkgs;
  };
  modules = [
    inputs.nix-doom-emacs-unstraightened.homeModule
    inputs.tmux-sessions.homeManagerModules.default
    ../../hosts/${host}/home.nix
    ../home-manager
  ];
}
