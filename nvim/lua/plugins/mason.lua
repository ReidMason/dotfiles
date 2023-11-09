return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "nvim/nvim-lspconfig",
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

        -- Dedicated handlers
        ["gopls"] = function()
          lspconfig.gopls.setup({
            cmd = { "gopls" },
            settings = {
              gopls = {
                completeUnimported = true,
                analyses = {
                  unusedparams = true,
                  usePlaceholders = false,
                  unusedvariable = true,
                  fieldalignment = true,
                  nilness = true,
                  shadow = true,
                  unusedwrite = true,
                },
              },
            },
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                  },
                  maxPreload = 100000,
                  preloadFileSize = 10000,
                },
              },
            },
          })
        end,
      })
    end,
  },
}
