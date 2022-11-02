vim.o.relativenumber = true -- Relative line numbers
vim.o.number = true -- Current line number
vim.o.title = true -- Terminal title same as vim path

vim.o.tabstop = 4 -- Spaces that a tab represents
vim.o.shiftwidth = 4 -- Spaces to use for auto indent
vim.o.expandtab = true -- Change tab to use spaces 
vim.o.autoindent = true -- Copy indent from current line to new line

vim.o.hlsearch = false -- Highlight searched items

vim.o.wrap = false -- Disable line wrap

vim.o.clipboard = "unnamed" -- Enable system clipboard

-- Keymaps
vim.g.mapleader = " "

vim.keymap.set("n", "<D-s>", "<cmd>update<cr>", {buffer = 0}) -- Save with ctrl+s
vim.keymap.set('n', '<leader>dl', "<cmd>Telescope diagnostics<cr>", {buffer = 0}) -- Open telescope errors list
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]] -- Format file on save
