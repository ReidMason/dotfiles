return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    notifier = { enabled = true },
    lazygit = { enabled = true },
    statuscolumn = { enabled = true },

    bigfile = { enabled = false },
    quickfile = { enabled = false },
    words = { enabled = false },
  },
}