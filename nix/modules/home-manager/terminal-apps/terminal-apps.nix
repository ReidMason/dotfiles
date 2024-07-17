{ pkgs, lib, config, ... }: {
  options.terminal-apps = {
    enable = lib.mkEnableOption "Enable all terminal-apps";

    bat.enable = lib.mkEnableOption "Enable bat";
    eza.enable = lib.mkEnableOption "Enable eza";

  };

  config = {
    terminal-apps.bat.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.eza.enable = lib.mkDefault config.terminal-apps.enable;

    home.packages = lib.concatLists [
      (lib.optional config.terminal-apps.bat.enable pkgs.bat)
      (lib.optional config.terminal-apps.eza.enable pkgs.eza)
    ];

    home.shellAliases = lib.mkMerge [
      (lib.mkIf config.terminal-apps.bat.enable {
       cat = "bat";
       })

      (lib.mkIf config.terminal-apps.eza.enable {
       # Eza aliases
       ls = "eza -lh --icons --no-user --group-directories-first";
       ll = "eza -lah --icons --no-user --no-time --group-directories-first";
       tree = "eza --tree --icons --no-user --no-time --group-directories-first";
       })
    ];
  };
}
