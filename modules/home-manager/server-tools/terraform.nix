{pkgs, pkgs-unstable, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "terraform";
  label = "Terraform";
  config = {
    home.packages = [
      pkgs-unstable.terraform
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
