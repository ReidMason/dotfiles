{ pkgs, lib, config, ... }: {
  options.terminal-apps = {
    enable = lib.mkEnableOption "Enable all terminal-apps";

    bat.enable = lib.mkEnableOption "Enable bat";
    eza.enable = lib.mkEnableOption "Enable eza";
    htop.enable = lib.mkEnableOption "Enable htop";
    glow.enable = lib.mkEnableOption "Enable glow";
    iperf.enable = lib.mkEnableOption "Enable iperf";
    rsync.enable = lib.mkEnableOption "Enable rsync";
    neofetch.enable = lib.mkEnableOption "Enable neofetch";
    zoxide.enable = lib.mkEnableOption "Enable zoxide";
    talosctl.enable = lib.mkEnableOption "Enable talosctl";
    kubectl.enable = lib.mkEnableOption "Enable kubectl";
    neovim.enable = lib.mkEnableOption "Enable neovim";
    just.enable = lib.mkEnableOption "Enable just";
  };

  config = {
    terminal-apps.bat.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.eza.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.htop.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.glow.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.iperf.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.rsync.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.neofetch.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.zoxide.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.talosctl.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.kubectl.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.neovim.enable = lib.mkDefault config.terminal-apps.enable;
    terminal-apps.just.enable = lib.mkDefault config.terminal-apps.enable;

    home.packages = lib.concatLists [
      (lib.optional config.terminal-apps.bat.enable pkgs.bat)
      (lib.optional config.terminal-apps.eza.enable pkgs.eza)
      (lib.optional config.terminal-apps.htop.enable pkgs.htop)
      (lib.optional config.terminal-apps.glow.enable pkgs.glow)
      (lib.optional config.terminal-apps.iperf.enable pkgs.iperf)
      (lib.optional config.terminal-apps.rsync.enable pkgs.rsync)
      (lib.optional config.terminal-apps.neofetch.enable pkgs.neofetch)
      (lib.optional config.terminal-apps.zoxide.enable pkgs.zoxide)
      (lib.optional config.terminal-apps.talosctl.enable pkgs.talosctl)
      (lib.optional config.terminal-apps.kubectl.enable pkgs.kubectl)

      (lib.optional config.terminal-apps.neovim.enable pkgs.unstable.neovim)
      (lib.optional config.terminal-apps.neovim.enable pkgs.ripgrep)
      (lib.optional config.terminal-apps.neovim.enable pkgs.lazygit)

      (lib.optional config.terminal-apps.just.enable pkgs.just)
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

      (lib.mkIf config.terminal-apps.zoxide.enable {
       cd = "z";
       })

      (lib.mkIf config.terminal-apps.kubectl.enable {
        k = "kubectl";
       })
    ];

    programs.zoxide.enable = config.terminal-apps.zoxide.enable;

    home.sessionVariables = lib.mkMerge [
      (lib.mkIf config.terminal-apps.neovim.enable {
        EDITOR = "nvim";
      })
    ]; 

    home.file = lib.mkIf config.terminal-apps.neovim.enable {
      ".config/nvim" = {
        source = ../../../configs/nvim;
      };
    };
  };
}
