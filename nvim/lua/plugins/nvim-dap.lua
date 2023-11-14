return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      vim.api.nvim_create_user_command("DapUiClose", function()
        require("dapui").close()
      end, {})

      require("dap-go").setup(opts)
    end,
  },
}
