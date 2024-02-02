local mappings = require "mappings"

return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = mappings.harpoon.keys,
}
