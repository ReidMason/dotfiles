{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  options,
  inputs,
  ...
}:
let
  module-name = "desktop-applications";
  mkModule =
    path:
    import path {
      inherit
        pkgs
        pkgs-unstable
        lib
        config
        options
        inputs
        ;
      parent-name = module-name;
    };
in
{
  imports = map mkModule [
    ./wezterm.nix
    ./firefox.nix
    ./ollama.nix
    ./obsidian.nix
    ./skhd.nix
    ./docker.nix
    ./lmstudio.nix
    ./ghostty.nix
    ./emacs.nix
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all desktop applications";
  };
}
