{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "firefox";
  label = "Firefox";
  config = {
    home.packages = [
      pkgs.firefox
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
