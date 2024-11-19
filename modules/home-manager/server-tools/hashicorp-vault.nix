{pkgs-unstable, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "vault";
  label = "Vault";
  config = {
    home.packages = with pkgs-unstable; [
      vault
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
