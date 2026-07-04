---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- disabled in favour of noice's notify/history so there's a single
    -- source of truth for messages instead of two competing vim.notify
    -- providers with separate histories
    notifier = { enabled = false },
    statuscolumn = { enabled = true },
    dashboard = { enabled = true },

    bigfile = { enabled = false },
    quickfile = { enabled = false },
    words = { enabled = false },

    picker = {
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.picker.snacks").send(...)
        end,
      },
      win = {
        input = {
          keys = {
            ["<A-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
          },
        },
      },
    },
  },
}
