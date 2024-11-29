{pkgs, pkgs-unstable, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "neovim";
  label = "Neovim";
  config = {
    home.packages = [
        pkgs-unstable.neovim
        pkgs.ripgrep
        pkgs.lazygit
        # pkgs.clang
        pkgs.lua
    ];

    home.sessionVariables = {
       EDITOR = "nvim";
    };

    home.file = {
      ".config/nvim" = {
        source = ../../../configs/nvim;
      };
    };
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
