return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    dependencies = {
      "nvim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()

      local lspconfig = require("lspconfig")
      local masonLspConfig = require("mason-lspconfig")

      masonLspConfig.setup_handlers({
        -- Default handler
        function(server)
          lspconfig[server].setup({})
        end,
      })
    end,
  },
}
