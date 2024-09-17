{ config, lib, parent-name, module-name, label, ... }:
{
  options.${module-name}.enable = lib.mkEnableOption label;

  config = {
    ${module-name}.enable = lib.mkDefault config.${parent-name}.enable;
  };
}
