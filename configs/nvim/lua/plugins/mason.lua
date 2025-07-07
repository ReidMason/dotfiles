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
      "neovim/nvim-lspconfig",
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

      lspconfig.hls.setup {
        capabilities = capabilities,
        cmd = { "haskell-language-server-wrapper", "--lsp" },
        filetypes = { "haskell" },
        root_dir = require("lspconfig").util.root_pattern(
          "*.cabal",
          "stack.yaml",
          "cabal.project",
          "package.yaml",
          ".git"
        ),
      }

      mason_lsp_config.setup_handlers {
        -- Default handler
        function(server)
          lspconfig[server].setup {
            capabilities = capabilities,
          }
        end,
      }
    end,
  },
}
