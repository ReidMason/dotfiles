---@type LazySpec
return {
  "folke/sidekick.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "Sidekick" },
  opts = {
    nes = { enabled = false },
    cli = {
      picker = "snacks",
      watch = true,
      mux = {
        enabled = true,
        backend = "tmux",
        create = "split",
        split = { vertical = true, size = 0.4 },
      },
      tools = {
        cursor = {},
      },
    },
  },
}
