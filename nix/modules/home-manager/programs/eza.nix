{ pkgs, lib, config, ... }: {
  options = {
    eza.enable = lib.mkEnableOption "Enable eza";
  };

  config = lib.mkIf config.eza.enable {
    home.packages = [
      pkgs.eza
    ];

    home.shellAliases = {
      # Eza aliases
      ls = "eza -lh --icons --no-user --group-directories-first";
      ll = "eza -lah --icons --no-user --no-time --group-directories-first";
      tree = "eza --tree --icons --no-user --no-time --group-directories-first";
    };
  };
}
