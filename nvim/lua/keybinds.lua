-- Not sure what this does
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remove highlight on esc
vim.keymap.set('n', '<esc>', ':noh<CR>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Leader mapping ]]
vim.keymap.set('n', '<leader>w', "<cmd>w!<CR>", { desc = 'Save' })
vim.keymap.set('n', '<leader>c', '<cmd>:confirm bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>qq', "<cmd>confirm qa<CR>", { desc = 'Quit' })

-- Diagnostic navigation keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<C-k>', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = "Rename" })

-- Switch between buffers
for i = 1, 9 do
	vim.keymap.set('n', string.format('<leader>%d', i), string.format("<cmd> BufferLineGoToBuffer %d <CR>", i))
end

vim.keymap.set('n', '<leader>/', "<Plug>(comment_toggle_linewise_current)", { desc = "Comment line" })
vim.keymap.set('v', '<leader>/', "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment line" })
