{pkgs, config, lib, options, parent-name, ...}:
let
module = {
  module-name = "eza";
  label = "Eza";
  config = {
    home.packages = with pkgs; [
      eza
    ];

    home.shellAliases = {
      ls = "eza -lh --icons --no-user --group-directories-first";
      ll = "eza -lah --group --icons --no-time --group-directories-first";
      tree = "eza --tree --icons --no-user --no-time --group-directories-first";
    };
  };
};
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
