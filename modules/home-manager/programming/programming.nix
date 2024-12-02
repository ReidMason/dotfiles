{ pkgs, pkgs-unstable, lib, config, options, ... }:
let
  module-name = "programming";
in
{
  imports = [
    (import ./python.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./git.nix { inherit pkgs lib options config; parent-name = module-name; })
    (import ./haskell.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
    (import ./node.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
  ];

  options.programming = {
    enable = lib.mkEnableOption "Enable all programming tools";

    golang.enable = lib.mkEnableOption "Enable Golang";
    lazygit.enable = lib.mkEnableOption "Enable Lazygit";
    rust.enable = lib.mkEnableOption "Enable rust";
  };

  config = {
    programming.golang.enable = lib.mkDefault config.programming.enable;
    programming.lazygit.enable = lib.mkDefault config.programming.enable;
    programming.rust.enable = lib.mkDefault config.programming.enable;

    home.packages = lib.concatLists [
      (lib.optional config.programming.golang.enable pkgs.go)
      (lib.optional config.programming.golang.enable pkgs.sqlc)
      (lib.optional config.programming.golang.enable pkgs.goose)

      (lib.optional config.programming.rust.enable pkgs.cargo)

      (lib.optional config.programming.lazygit.enable pkgs.lazygit)
    ];
  };
}
