{ pkgs, lib, config, ... }: {
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux";
  };

  config = lib.mkIf config.tmux.enable {
    home.packages = [
      (pkgs.stdenv.mkDerivation rec {
        pname = "tmux";
        version = "next-3.5";

        src = pkgs.fetchFromGitHub {
          owner = "tmux";
          repo = "tmux";
          rev = "3c2621b41b9e1466d2b06718a0a8514f5d10ded9"; # Use the exact commit or tag here
          sha256 = "sha256-IySSTUl7ur49brFk3seUUep1n68hCmbPA0qAfeiPNIg"; # Use the correct sha256 here
        };

        buildInputs = [ pkgs.autoreconfHook pkgs.pkg-config pkgs.libevent pkgs.ncurses pkgs.yacc pkgs.utf8proc ];

        configureFlags = [ "--enable-utf8proc" ];
        buildPhase = ''
          sh autogen.sh
          ./configure $configureFlags
          make
        '';
      })
    ];

    programs.tmux = {
      enable = true;
      prefix = "C-Space";
      terminal = "xterm-256color";
      escapeTime = 0;
      baseIndex = 1;
      mouse = true;
      extraConfig = ''
        # Reload tmux config
        bind r source-file ~/.config/tmux/tmux.conf

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
