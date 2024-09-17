{ config, lib, parent-name, module-name, label, ... }:
{
  options.${parent-name}.${module-name}.enable = lib.mkEnableOption label;

  config = {
    ${parent-name}.${module-name}.enable = lib.mkDefault config.${parent-name}.enable;
  };
}
