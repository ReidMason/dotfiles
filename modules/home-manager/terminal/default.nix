{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  options,
  ...
}:
let
  module-name = "terminal";
  mkModule =
    path:
    import path {
      inherit
        pkgs
        pkgs-unstable
        lib
        config
        options
        ;
      parent-name = module-name;
    };
in
{
  imports =
    map mkModule [
      ./starship.nix
      ./bat.nix
      ./cursor-cli.nix
      ./eza.nix
      ./tmux.nix
      ./btop.nix
      ./neovim.nix
      ./sysbench.nix
      ./dust.nix
      ./glow.nix
      ./zoxide.nix
      ./kubectl.nix
      ./iperf.nix
      ./rsync.nix
      ./fastfetch.nix
      ./talosctl.nix
      ./just.nix
      ./television.nix
      ./sesh.nix
      ./yazi.nix
      ./zsh.nix
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin (
      map mkModule [
        ./blueutil.nix
      ]
    );

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all terminal apps";
  };
}
