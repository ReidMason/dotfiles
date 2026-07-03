---@type LazySpec
return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    return {
      view = {
        default = {
          layout = "diff1_plain",
        },
        merge_tool = {
          layout = "diff3_horizontal",
        },
      },
      keymaps = require("mappings").diffview_plugin_keymaps(),
    }
  end,
}
