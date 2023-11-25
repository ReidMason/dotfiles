return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        auto_install = true,
        autotag = {
          enable = true,
        },
        highlight = {
          enable = true,
        },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
  },
}
