{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "python";
  label = "Python";
  config = {
    home.packages = with pkgs; [
      python3
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
