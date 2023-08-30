local flashNvim = require "custom.flash"
local autocomplete = require "custom.autocomplete"

local plugins = {
  flashNvim,
  autocomplete,
  {
    "NvChad/nvterm",
    opts = {
      terminals = {
        type_opts = {
          float = {
            border = "rounded",
            row = 0.15,
            col = 0.15,
            height = 0.7,
            width = 0.7,
          },
        },
      },
    },
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
    -- Can't get this to stage files though the diff view is good
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    enabled = false,
    event = "VeryLazy",
    config = function()
      local actions = require("diffview.config").actions

      return {
        keymaps = {
          file_panel = {
            ["<C-p>"] = actions.toggle_stage_entry,
          },
        },
      }
    end,
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
