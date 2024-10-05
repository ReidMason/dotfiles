{ pkgs, pkgs-unstable, lib, config, options, ... }: 
let
module-name = "terminal";
in
{
  imports = [
     (import ./starship.nix { inherit pkgs lib options config; parent-name = module-name; })
     (import ./bat.nix { inherit pkgs lib options config; parent-name = module-name; })
     (import ./eza.nix { inherit pkgs lib options config; parent-name = module-name; })
     (import ./tmux.nix { inherit pkgs pkgs-unstable lib options config; parent-name = module-name; })
  ];

  options.${module-name} = {
    enable = lib.mkEnableOption "Enable all terminal apps";

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
    terminal.htop.enable = lib.mkDefault config.terminal.enable;
    terminal.glow.enable = lib.mkDefault config.terminal.enable;
    terminal.iperf.enable = lib.mkDefault config.terminal.enable;
    terminal.rsync.enable = lib.mkDefault config.terminal.enable;
    terminal.neofetch.enable = lib.mkDefault config.terminal.enable;
    terminal.zoxide.enable = lib.mkDefault config.terminal.enable;
    terminal.talosctl.enable = lib.mkDefault config.terminal.enable;
    terminal.kubectl.enable = lib.mkDefault config.terminal.enable;
    terminal.neovim.enable = lib.mkDefault config.terminal.enable;
    terminal.just.enable = lib.mkDefault config.terminal.enable;

    home.packages = lib.concatLists [
        (lib.optional config.terminal.htop.enable pkgs.htop)
        (lib.optional config.terminal.glow.enable pkgs.glow)
        (lib.optional config.terminal.iperf.enable pkgs.iperf)
        (lib.optional config.terminal.rsync.enable pkgs.rsync)
        (lib.optional config.terminal.neofetch.enable pkgs.neofetch)
        (lib.optional config.terminal.zoxide.enable pkgs.zoxide)
        (lib.optional config.terminal.talosctl.enable pkgs.talosctl)
        (lib.optional config.terminal.kubectl.enable pkgs.kubectl)

        (lib.optional config.terminal.neovim.enable pkgs-unstable.neovim)
        (lib.optional config.terminal.neovim.enable pkgs.ripgrep)
        (lib.optional config.terminal.neovim.enable pkgs.lazygit)

        (lib.optional config.terminal.just.enable pkgs.just)
    ];

    home.shellAliases = lib.mkMerge [
    (lib.mkIf config.terminal.zoxide.enable {
     cd = "z";
     })

    (lib.mkIf config.terminal.kubectl.enable {
     k = "kubectl";
     kn = "kubectl config set-context --current --namespace";
     })
    ];

    programs.zoxide.enable = config.terminal.zoxide.enable;

    home.sessionVariables = lib.mkMerge [
      (lib.mkIf config.terminal.neovim.enable {
       EDITOR = "nvim";
       })
    ]; 

    home.file = lib.mkIf config.terminal.neovim.enable {
      ".config/nvim" = {
        source = ../../../configs/nvim;
      };
    };
  };
}
