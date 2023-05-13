lvim.plugins = {
  { "folke/trouble.nvim" },
  { "simrat39/rust-tools.nvim" },
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup {
        transparent = true,
        lualine = {
          transparent = false,
        },
      }
    end
  },
  { "tpope/vim-fugitive" },
  { "unblevable/quick-scope" },
  { "mattn/emmet-vim" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end
  },
  {
    "goolord/alpha-nvim"
  }
}
