{pkgs, config, lib, options, parent-name, ...}:
let
module-name = "bat";
label = "Bat";
data = {
  home.packages = [
    pkgs.bat
  ];

  home.shellAliases = {
    cat = "bat";
  };
};
in
{
  imports = [
    (import ./boilerplate.nix { inherit config lib parent-name data module-name label; })
  ];
}
