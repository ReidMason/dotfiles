---@type LazySpec
return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "esmuellert/codediff.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    integrations = {
      codediff = true,
      telescope = true,
    },
    diff_viewer = "codediff",
  },
}
