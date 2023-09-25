local customMasonOpts = {
  ensure_installed = {
    "html-lsp",
    "prettier",
    "stylua",
    "rust-analyzer",
    "gopls",
    "yaml-language-server",
    -- "typescript-language-server",
    "eslint-lsp",
    "astro-language-server",
  },
}

local masonOpts = require "plugins.configs.mason"

masonOpts.ensure_installed = vim.list_extend(masonOpts.ensure_installed, customMasonOpts.ensure_installed)

return {
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
    opts = masonOpts,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function()
      return require "custom.configs.cmp"
    end,
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
}
