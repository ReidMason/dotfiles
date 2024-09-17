{ config, lib, module-name, parent-name, data, label }:
{
  imports = [
    (import ./builder.nix { inherit config lib parent-name module-name label; })
  ];

  config = lib.mkIf config.${module-name}.enable data;
}
