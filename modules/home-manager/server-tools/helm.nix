{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "helm";
  label = "Helm";
  config = {
    home.packages = [
      pkgs.kubernetes-helm
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
