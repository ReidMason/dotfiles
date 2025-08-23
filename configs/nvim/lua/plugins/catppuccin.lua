return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    custom_highlights = function(colours)
      return {
        NormalFloat = { bg = colours.base },
      }
    end,
    integrations = {
      cmp = true,
      notify = true,
      harpoon = true,
      which_key = true,
      mason = true,
      telescope = {
        enabled = true,
      },
      nvimtree = true,
    },
  },
}
