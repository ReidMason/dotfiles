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
    };
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
