local opts = require "plugins.configs.treesitter"
opts.ensure_installed = {
  "lua",
  "sql",
  "rust",
  "go",
}

return {
  "nvim-treesitter/nvim-treesitter",
  opts = opts,
}
