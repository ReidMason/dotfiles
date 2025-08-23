local icons = require "core.icons"

-- To debug use
--  :checkhealth vim.lsp
local lsp_configs = {
  'gopls',
  'lua_ls',
  'astro',
  'docker_compose_language_service',
  'nixd',
  'tailwindcss',
  'ts_ls',
  'yamlls',
  'terraform_lsp'
}

vim.lsp.enable(lsp_configs)

vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error .. " ",
      [vim.diagnostic.severity.WARN] = icons.Warn .. " ",
      [vim.diagnostic.severity.INFO] = icons.Info .. " ",
      [vim.diagnostic.severity.HINT] = icons.Hint .. " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
}
