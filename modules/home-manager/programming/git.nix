{
  pkgs,
  config,
  lib,
  options,
  parent-name,
  ...
}:
let
  module = {
    module-name = "git";
    label = "Git";
    config = {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Reid Mason";
            email = "maddogshain132@gmail.com";
          };
          alias = {
            lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
          };
        };
      };

      home.shellAliases = {
        g = "git";
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
