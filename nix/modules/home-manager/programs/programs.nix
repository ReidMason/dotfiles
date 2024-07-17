{ pkgs, lib, config, ... }: {
  options.programs = {
    enable = lib.mkEnableOption "Enable all programs";

    batcat.enable = lib.mkEnableOption "Enable bat";
    eza.enable = lib.mkEnableOption "Enable eza";
  };

  config = {
    programs.batcat.enable = lib.mkDefault config.programs.enable;
    programs.eza.enable = lib.mkDefault config.programs.enable;

    home.packages = lib.concatLists [
      (lib.optional config.programs.batcat.enable pkgs.bat)
      (lib.optional config.programs.eza.enable pkgs.eza)
    ];

    home.shellAliases = lib.mkMerge [
      (lib.mkIf config.programs.batcat.enable {
       cat = "bat";
       })

      (lib.mkIf config.programs.eza.enable {
       # Eza aliases
       ls = "eza -lh --icons --no-user --group-directories-first";
       ll = "eza -lah --icons --no-user --no-time --group-directories-first";
       tree = "eza --tree --icons --no-user --no-time --group-directories-first";
       })
    ];
  };
}
