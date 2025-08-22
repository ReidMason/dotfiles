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
    module-name = "node";
    label = "NodeJs";
    config = {
      home.packages = with pkgs; [
        nodejs
        pnpm
        prettierd
        typescript
        typescript-language-server
        tailwindcss-language-server
        astro-language-server
      ];
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
