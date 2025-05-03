{ pkgs, pkgs-unstable, lib, config, options, ... }:
let
  module-name = "terminal";
in
{
  imports = [
    (import ./starship.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./bat.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./eza.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./tmux.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./btop.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./neovim.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./sysbench.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./dust.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./glow.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./zoxide.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./kubectl.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./iperf.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./rsync.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./neofetch.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./talosctl.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./just.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./zsh.nix)
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all terminal apps";
  };
}
