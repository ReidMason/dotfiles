local plugins = {
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
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
}

return plugins
