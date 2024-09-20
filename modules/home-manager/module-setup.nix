{ config, lib, parent-name, module }:
{
  options.${module.module-name}.enable = lib.mkEnableOption module.label;

  config = lib.mkMerge [
    {${module.module-name}.enable = lib.mkDefault config.${parent-name}.enable;}
    (lib.mkIf config.${module.module-name}.enable module.config)
  ];
}
