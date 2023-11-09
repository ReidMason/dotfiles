local on_attach = function(client, bufnr)
  local util = require("lspconfig/util")
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  util.load_mappings("lspconfig", { buffer = bufnr })

  if not util.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

return{
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "nvim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig/util")

    local masonLspConfig = require("mason-lspconfig")
    masonLspConfig.setup({
      ensure_installed = {'lua_ls', 'gopls'}
    })

    masonLspConfig.setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server)
        lspconfig[server].setup({})
      end,

      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:
      ["lua_ls"] = function ()
        lspconfig.lua_ls.setup {
          settings = {
            Lua = {
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
          }
        }
      end,

      ["gopls"] = function ()
        lspconfig.gopls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = util.root_pattern("go.work", "go.mod", ".git"),
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
      end
    }
  end,
}
