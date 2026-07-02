---@type LazySpec
return {
  {
    "folke/lazydev.nvim",
    version = "^1.10.0",
    ft = "lua", -- only load on lua files
    lazy = false,
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim",          words = { "Lazy%a+" } },
      },
    },
  },
}
