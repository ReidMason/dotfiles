{ pkgs-unstable, config, lib, options, parent-name, ... }:
let
  module = {
    module-name = "tmux";
    label = "Tmux";
    config = {
      programs.tmux.package = pkgs-unstable.tmux;

      programs.tmux = {
        enable = true;
        prefix = "M-Space";
        terminal = "xterm-256color";
        escapeTime = 0;
        baseIndex = 1;
        mouse = true;
        extraConfig = ''
          # Reload tmux config
          bind r source-file ~/.config/tmux/tmux.conf

          # Enable full rgb colours
          set-option -sa terminal-overrides ",xterm*:Tc"

          # Split panes
          bind h split-window -v -c "#{pane_current_path}"
          bind v split-window -h -c "#{pane_current_path}"

          # Don't detach when destroying a session
          set-option -g detach-on-destroy off 

          # Window deletion
          bind w kill-window

          # Switch windows
          bind j select-window -t 1
          bind k select-window -t 2
          bind l select-window -t 3
          # bind ; select-window -t 4

          # Toggle between last active windows
          bind -n M-o switch-client -l

          # Switch Pane positions
          bind -n M-[ swap-pane -D
          bind -n M-] swap-pane -U

          # General config
          set -g renumber-windows on    # Renumber all windows when any window is closed
          set -g set-clipboard on       # Use system clipboard

          set-option -g status-interval 5
          set -g status-interval 2      # Update status every 2 seconds
          set -g status-position top    # macOS / darwin style

          # Switch panes
          is_vim="ps -o state= -o comm= -t \'#{pane_tty}\' | grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$\'"

          bind-key -n "M-h" if-shell "$is_vim" "send-keys M-h" { if -F "#{pane_at_left}" "" "select-pane -L" }
          bind-key -n "M-j" if-shell "$is_vim" "send-keys M-j" { if -F "#{pane_at_bottom}" "" "select-pane -D" }
          bind-key -n "M-k" if-shell "$is_vim" "send-keys M-k" { if -F "#{pane_at_top}" "" "select-pane -U" }
          bind-key -n "M-l" if-shell "$is_vim" "send-keys M-l" { if -F "#{pane_at_right}" "" "select-pane -R" }

          bind-key -T copy-mode-vi "M-h" if -F "#{pane_at_left}" "" "select-pane -L"
          bind-key -T copy-mode-vi "M-j" if -F "#{pane_at_bottom}" "" "select-pane -D"
          bind-key -T copy-mode-vi "M-k" if -F "#{pane_at_top}" "" "select-pane -U"
          bind-key -T copy-mode-vi "M-l" if -F "#{pane_at_right}" "" "select-pane -R"

          # Resize panes
          bind -n M-J resize-pane -D 10
          bind -n M-K resize-pane -U 10
          bind -n M-H resize-pane -L 10
          bind -n M-L resize-pane -R 10

          # Tmux sensible fix for tmux 3.5 and 3.5a to stop zsh from breaking
          # Without this the default shell will be /bin/sh
          set -gu default-command
          set -g default-shell "$SHELL"
        '';
        plugins = [
          {
            plugin = pkgs-unstable.tmuxPlugins.catppuccin;
            extraConfig = ''
              set -g @catppuccin_flavor "mocha"

              set -g @catppuccin_window_status_style "custom"
              set -g @catppuccin_window_left_separator " "
              set -g @catppuccin_window_right_separator " "
              set -g @catppuccin_window_middle_separator " "

              set-window-option -g window-status-current-style "fg=#{@thm_pink}"
              set-window-option -g window-status-style "fg=#{@thm_overlay_2}"
              set -g @catppuccin_window_text_color "none"
              set -g @catppuccin_window_number_color "none"
              set -g @catppuccin_window_current_text_color "none"
              set -g @catppuccin_window_current_number_color "none"

              set -g @catppuccin_window_text "#W"
              set -g @catppuccin_window_current_text "#W"

              set -g @catppuccin_status_background "none"
              set -g status-right "#{E:@catppuccin_status_session}"
              set -g status-left ""
            '';
          }
          pkgs-unstable.tmuxPlugins.sensible
        ];
      };
    };
  };
in
{
  imports = [
    (import ../module-setup.nix { inherit config lib parent-name module; })
  ];
}
