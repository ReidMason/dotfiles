---@type LazySpec
return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
    diff_viewer = "diffview",
  },
}
