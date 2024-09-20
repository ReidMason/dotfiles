{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "bat";
  label = "Bat";
  config = {
    home.packages = [
      pkgs.bat
    ];

    home.shellAliases = {
      cat = "bat";
    };
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
