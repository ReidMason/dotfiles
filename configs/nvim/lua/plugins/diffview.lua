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
    local actions = require("diffview.actions")

    return {
      view = {
        default = {
          layout = "diff1_plain",
        },
        merge_tool = {
          layout = "diff3_horizontal",
        },
      },
      keymaps = {
        view = {
          { "n", "q", actions.close, { desc = "Close diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>tabclose<cr>", { desc = "Close diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>tabclose<cr>", { desc = "Close diffview" } },
        },
      },
    }
  end,
}
