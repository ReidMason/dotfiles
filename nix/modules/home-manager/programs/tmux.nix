{ pkgs, lib, config, ... }: {
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.tmux.enable {
    home.packages = [
      pkgs.tmux
    ];

    programs.tmux = {
      enable = true;
      prefix = "C-Space";
      terminal = "xterm-256color";
      escapeTime = 0;
      baseIndex = 1;
      mouse = true;
      extraConfig = ''
        # Enable full rgb colours
        set-option -sa terminal-overrides ",xterm*:Tc"

        set-option -g status-interval 5
        # Don't detach when destroying a session
        set-option -g detach-on-destroy off 

        # Split panes
        bind h split-window -v -c "#{pane_current_path}"
        bind v split-window -h -c "#{pane_current_path}"

        # Don't detach when destroying a session
        set-option -g detach-on-destroy off 

        # Switch windows
        bind -n M-q select-window -t 1
        bind -n M-w select-window -t 2
        bind -n M-e select-window -t 3
        bind -n M-r select-window -t 4

        # Toggle between last active windows
        bind -n M-o switch-client -l

        # Switch Pane positions
        bind -n M-[ swap-pane -D
        bind -n M-] swap-pane -U

        # General config
        set -g renumber-windows on    # Renumber all windows when any window is closed
        set -g set-clipboard on       # Use system clipboard
        set -g status-interval 2      # Update status every 2 seconds
        set -g status-right ""      # Empty right statusline
        set -g status-position top    # macOS / darwin style
      '';
      plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_left_separator " "
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " "

          set -g @catppuccin_window_default_fill "all"
          set -g @catppuccin_window_default_color "bg"
          set -g @catppuccin_window_default_background "none"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_window_current_color "magenta"
          set -g @catppuccin_window_current_background "none"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules_right "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
        '';
      }
        pkgs.tmuxPlugins.sensible
      ];
    };

    # home.file = {
    #   ".config/tmux" = {
    #     source = ../../../../tmux;
    #   };
    # };
  };
}
