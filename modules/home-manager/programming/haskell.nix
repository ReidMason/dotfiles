{pkgs, pkgs-unstable, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "haskell";
  label = "Haskell";
  config = {
    home.packages = with pkgs; [
      ghc
      cabal-install
      haskell-language-server
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
