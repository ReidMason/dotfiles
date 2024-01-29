return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = function()
    local colours = require "core.colours"

    return {
      options = {
        icons_enabled = true,
        theme = {
          normal = {
            a = { fg = colours.blue, bg = colours.base },
            b = { fg = colours.sapphire, bg = colours.base },
            c = { fg = colours.rosewater, bg = colours.base },
            x = { fg = colours.rosewater, bg = colours.base },
            y = { fg = colours.lavender, bg = colours.base },
            z = { fg = colours.overlay1, bg = colours.base },
          },
          insert = {
            a = { fg = colours.green, bg = colours.base },
            z = { fg = colours.overlay1, bg = colours.base },
          },
          visual = {
            a = { fg = colours.lavender, bg = colours.base },
            z = { fg = colours.overlay1, bg = colours.base },
          },
          terminal = {
            a = { fg = colours.peach, bg = colours.base },
            z = { fg = colours.overlay1, bg = colours.base },
          },
        },
        component_separators = { left = " ", right = " " },
        disabled_filetypes = {
          -- statusline = { "NvimTree" },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰝶 ",
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            symbols = { modified = "  ", readonly = "", unnamed = "" },
          },
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = colours.green },
          },
          "diff",
        },
        lualine_y = {},
        lualine_z = {
          function()
            return "  " .. os.date "%X"
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
