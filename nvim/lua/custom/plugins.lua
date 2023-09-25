local flashNvim = require "custom.flash"
local autocomplete = require "custom.autocomplete"
local treesitter = require "custom.treesitter"

local plugins = {
  flashNvim,
  autocomplete,
  treesitter,
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = require("custom.configs.noice").opts,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000",
    },
  },
  {
    -- Nice ui for builtin neovim prompts like rename and code_actions
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
}

return plugins
