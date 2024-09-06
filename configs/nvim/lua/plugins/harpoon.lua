local mappings = require "mappings"

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = mappings.harpoon.keys,
  opts = {
    settings = {
      save_on_toggle = true,
      save_on_change = true,
    },
  },
}
