{pkgs, config, lib, options, parent-name, ...}:
let
module-name = "eza";
label = "Eza";
data = {
  home.packages = with pkgs; [
    eza
  ];

  home.shellAliases = {
    ls = "eza -lh --icons --no-user --group-directories-first";
    ll = "eza -lah --icons --no-user --no-time --group-directories-first";
    tree = "eza --tree --icons --no-user --no-time --group-directories-first";
  };
};
in
{
  imports = [
    (import ./boilerplate.nix { inherit config lib parent-name data module-name label; })
  ];
}
