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
      blink_cmp = true,
      gitsigns = true,
      harpoon = true,
      notify = true,
      noice = true,
      snacks = true,
      telescope = {
        enabled = true,
      },
    },
  },
}
