{ config, lib, module-name, parent-name, data, label }:
{
  options.${module-name}.enable = lib.mkEnableOption label;

  config = lib.mkMerge [
    {${module-name}.enable = lib.mkDefault config.${parent-name}.enable;}
    (lib.mkIf config.${module-name}.enable data)
  ];
}
