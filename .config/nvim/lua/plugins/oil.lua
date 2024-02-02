return {
  "stevearc/oil.nvim",
  opts = {
    keymaps = {
      ["q"] = "actions.close",
    },
    view_options = {
      is_hidden_file = function(name, _)
        return vim.startswith(name, ".") and name ~= ".zshrc"
      end,
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
}
