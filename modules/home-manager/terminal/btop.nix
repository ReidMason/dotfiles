{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "btop";
  label = "Btop";
  config = {
    home.packages = with pkgs; [
      btop
    ];

    programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
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
