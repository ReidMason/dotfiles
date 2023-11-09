return {
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {"NvChad/nvim-colorizer.lua",
  opts = {
    filetypes = {"*"},
    user_default_options = {
      names = false,
      tailwind = true,
      css = true,
      css_fn = true,
    },
  }
},
{ "catppuccin/nvim",
name = "catppuccin",
priority = 1000,
opts = {
  transparent_background = true,
  integrations = {
    notify = true,
    harpoon = true,
  }
}
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {},
    config = function()
      require'nvim-treesitter.configs'.setup{
      auto_install=true,
      highlight = {
        enable = true
      }
      }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = {"Telescope"},
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  }
}
