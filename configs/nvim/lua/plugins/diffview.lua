---@type LazySpec
return {
  "dlyongemallo/diffview.nvim",
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
          layout = "diff1_inline",
        },
        merge_tool = {
          layout = "diff3_horizontal",
        },
        inline = {
          style = "unified",
        },
      },
      keymaps = require("mappings").diffview_plugin_keymaps(),
    }
  end,
}
