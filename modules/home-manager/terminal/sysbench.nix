{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "sysbench";
  label = "Sysbench";
  config = {
    home.packages = with pkgs; [
      sysbench
    ];

    home.shellAliases = {
      sysbench-cpu = "sysbench --threads=\"$(nproc)\" cpu run";
    };
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
