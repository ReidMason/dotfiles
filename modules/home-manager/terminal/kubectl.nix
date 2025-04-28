{ pkgs, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "kubectl";
    label = "Kubectl";
    config = {
      home.packages = [
        pkgs.kubectl
      ];
      home.shellAliases = {
        k = "kubectl";
        kn = "kubectl config set-context --current --namespace";
      };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
} 