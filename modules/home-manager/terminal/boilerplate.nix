{ config, lib, module-name, parent-name, data, label }:
let
shouldrun = import ./shouldrun.nix { inherit config parent-name module-name; };
in
{
  imports = [
    (import ./builder.nix { inherit config lib parent-name module-name label; })
  ];

  config = lib.mkIf shouldrun data;
}
