return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    integrations = {
      cmp = true,
      gitsigns = true,
      notify = true,
      harpoon = true,
      which_key = true,
      mason = true,
      telescope = {
        enabled = true,
        -- style = "nvchad",
      },
      dap = {
        enabled = true,
        enable_ui = true,
      },
      nvimtree = true,
    },
  },
}
