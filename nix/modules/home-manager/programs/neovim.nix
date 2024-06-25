{ pkgs, lib, config, ... }: {
  options = {
    neovim.enable = lib.mkEnableOption "Enable neovim";
  };

  config = lib.mkIf config.neovim.enable {
    home.packages = [
      pkgs.neovim
    ];

    home.file = {
      ".config/nvim" = {
        source = ../../../../nvim;
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
