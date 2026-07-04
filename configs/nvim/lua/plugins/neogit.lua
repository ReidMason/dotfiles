---@type LazySpec
return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "dlyongemallo/diffview.nvim",
    "folke/snacks.nvim",
  },
  opts = {
    integrations = {
      diffview = true,
      telescope = false,
      snacks = true,
    },
    diff_viewer = "diffview",
  },
}
