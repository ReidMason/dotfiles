{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  options,
  parent-name,
  ...
}:
let
  module = {
    module-name = "neovim";
    label = "Neovim";
    config = {
      home.packages = [
        pkgs-unstable.neovim
        pkgs-unstable.tree-sitter
        pkgs.ripgrep
        pkgs.lazygit
        pkgs.clang
        pkgs.lua
        pkgs.lua-language-server

        # nix tools
        pkgs.nil
        pkgs.nixfmt-rfc-style # Formatter
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      home.file = {
        # Everything except lazy-lock.json is immutable, symlinked from the Nix store.
        ".config/nvim" = {
          source = lib.fileset.toSource {
            root = ../../../configs/nvim;
            fileset = lib.fileset.difference ../../../configs/nvim ../../../configs/nvim/lazy-lock.json;
          };
          recursive = true;
        };

        # lazy-lock.json is symlinked directly to the repo checkout (out of the
        # store) so lazy.nvim can write updated plugin commits to it.
        ".config/nvim/lazy-lock.json".source =
          config.lib.file.mkOutOfStoreSymlink "${config.dotfilesDir}/configs/nvim/lazy-lock.json";
      };

      home.shellAliases = {
        v = "nvim";
        vim = "nvim";
      };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix {
      inherit
        config
        lib
        parent-name
        module
        ;
    })
  ];
}
