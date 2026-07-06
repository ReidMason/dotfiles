---@type core.Icons
local icons = require "core.icons"

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
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = icons.FindFile .. " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = icons.NewFile .. " ",  key = "n", desc = "New File",  action = ":ene | startinsert" },
          { icon = icons.FindText .. " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = icons.BrowseRepo .. " ",
            key = "b",
            desc = "Browse Repo",
            action = function()
              Snacks.gitbrowse()
            end,
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
          },
          {
            icon = icons.Neogit .. " ",
            key = "G",
            desc = "Neogit",
            action = ":Neogit",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
          },
          { icon = icons.RestoreSession .. " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = icons.Lazy .. " ",           key = "L", desc = "Lazy",            action = ":Lazy",   enabled = package.loaded.lazy ~= nil },
          { icon = icons.Quit .. " ",           key = "q", desc = "Quit",            action = ":qa" },
        },
      },
    },

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
