{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "nix-language";
  label = "Nix-language";
  config = {
    home.packages = with pkgs; [
      pkgs.nixd
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
