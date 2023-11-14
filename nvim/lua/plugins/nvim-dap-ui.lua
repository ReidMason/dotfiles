return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap" },
  lazy = false,
  config = function()
    require("dapui").setup()
  end,
}
