local plugins = {
  {
    "codethread/qmk.nvim",
    event = "VeryLazy",
    config = function()
      local qmk = require "qmk"
      qmk.setup {
        name = "LAYOUT",
        layout = { -- create a visual representation the final layout
          "x x x x x x _ _ _ _ _ _ x x x x x x",
          "x x x x x x _ _ _ _ _ _ x x x x x x",
          "x x x x x x x x _ _ x x x x x x x x",
          "_ _ _ x x x x x _ _ x x x x x _ _ _",
        },
      }
    end,
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
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = require("custom.configs.flash").opts,
    keys = require("custom.configs.flash").keys,
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
    "f-person/git-blame.nvim",
    enabled = false,
    event = "VeryLazy",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = require("custom.configs.mason").opts,
  },
  {
    -- Nice ui for builtin neovim prompts like rename and code_actions
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = "rust",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_fail_silently = 1
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function()
      return require "custom.configs.cmp"
    end,
  },
}

return plugins
