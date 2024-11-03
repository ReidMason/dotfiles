{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "python";
  label = "Python";
  config = {
    home.packages = with pkgs; [
      (pkgs.python311.withPackages (ppkgs: [ ppkgs.requests ]))
    ];
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
