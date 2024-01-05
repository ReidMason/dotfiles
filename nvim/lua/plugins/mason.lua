-- Rounded borders for hover stuff
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.diagnostic.config {
  float = { border = _border },
}

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
      vim.filetype.add {
        pattern = {
          -- ansible playbook
          [".*/.*playbook.*.ya?ml"] = "yaml.ansible",
          [".*/.*tasks.*/.*ya?ml"] = "yaml.ansible",
          [".*/local.ya?ml"] = "yaml.ansible",
        },
      }

      require("mason").setup()
      local capabilities = require("core.utils").get_capabilities()

      local lspconfig = require "lspconfig"
      local mason_lsp_config = require "mason-lspconfig"

      mason_lsp_config.setup_handlers {
        -- Default handler
        function(server)
          lspconfig[server].setup {
            capabilities = capabilities,
          }
        end,

        -- Dedicated handlers
        ["gopls"] = function()
          lspconfig.gopls.setup {
            cmd = { "gopls" },
            capabilities = capabilities,
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
          }
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                format = {
                  enable = false,
                },
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                  },
                  maxPreload = 100000,
                  preloadFileSize = 10000,
                },
              },
            },
          }
        end,
      }
    end,
  },
}
