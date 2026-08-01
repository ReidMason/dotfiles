{
  pkgs,
  config,
  lib,
  parent-name,
  ...
}:
let
  module = {
    module-name = "claude-code";
    label = "Claude code";
    config = {
      programs.claude-code = {
        enable = true;
        package = pkgs.claude-code;
        context = ../../../configs/claude/CLAUDE.md;
        skillsDir = ../../../configs/claude/skills;
      };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix {
      inherit
        config
        lib
        parent-name
        module
        ;
    })
  ];
}
