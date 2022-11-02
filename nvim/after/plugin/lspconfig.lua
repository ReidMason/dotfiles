-- Setup LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local keymap = vim.keymap
-- Golang
require'lspconfig'.gopls.setup { 
    capabilities = capabilities, -- Register autocomplete
    on_attach = function()
        keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
        keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
        keymap.set("n", "R", vim.lsp.buf.rename, {buffer = 0})
        keymap.set("n", "L", vim.lsp.buf.format, {buffer = 0})
        keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
        keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
        keymap.set("n", "<leader>df", vim.diagnostic.goto_next, {buffer = 0})
        keymap.set("n", "<leader>dF", vim.diagnostic.goto_prev, {buffer = 0})
    end
}
