---@type LazySpec[]
return {
  {
    "nvim-mini/mini.pairs",
    version = false,
    event = "InsertEnter",
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
    config = function(_, opts)
      require("mini.pairs").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("MiniPairsDisable", { clear = true }),
        pattern = { "snacks_input", "vim" },
        callback = function(ev)
          vim.b[ev.buf].mini_pairs_disable = true
        end,
      })
    end,
  },
  {
    "nvim-mini/mini.surround",
    version = false,
    keys = {
      { "ys", mode = { "n", "x" } },
      { "cs", mode = "n" },
      { "ds", mode = "n" },
      { "sf", mode = "n" },
      { "sF", mode = "n" },
      { "sh", mode = "n" },
    },
    opts = {
      -- tpope/vim-surround compatible mappings for add/change/delete
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
      },
    },
  },
}
