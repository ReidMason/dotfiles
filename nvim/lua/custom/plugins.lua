local flashNvim = require "custom.flash"
local autocomplete = require "custom.autocomplete"

local plugins = {
  flashNvim,
  autocomplete,
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
    event = "BufReadPost",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = require("custom.configs.noice").opts,
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
