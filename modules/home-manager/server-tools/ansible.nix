{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "ansible";
  label = "Ansible";
  config = {
    home.packages = [
      pkgs.ansible
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
