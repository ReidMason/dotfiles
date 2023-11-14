return {
  "simrat39/rust-tools.nvim",
  ft = "rust",
  dependencies = "neovim/nvim-lspconfig",
  opts = function()
    return {
      capabilities = require("core.utils").get_capabilities(),
    }
  end,
  setup = function(_, opts)
    require("rust-tools").setup(opts)
  end,
}
