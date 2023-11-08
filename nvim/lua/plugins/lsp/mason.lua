return{
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "nvim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    local lspconfig = require("lspconfig")
    local masonLspConfig = require("mason-lspconfig")
    masonLspConfig.setup({
      ensure_installed = {'lua_ls'}
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
      end
    }
  end,
}
