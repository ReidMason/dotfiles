{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "git";
  label = "Git";
  config = {
    programs.git = {
      enable = true;
      userName = "Reid Mason";
      userEmail = "maddogshain132@gmail.com";
      aliases = {
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      };
    };
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
