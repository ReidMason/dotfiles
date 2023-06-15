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
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })

-- Diagnostic navigation keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<C-k>', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

vim.keymap.set('n', '<leader>qq', "<cmd>confirm q<CR>", { desc = 'Quit' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').live_grep, { desc = '[S]earch [T]ext' })

vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions)
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references)

vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = "Rename" })

-- Switch between buffers
for i = 1, 10, 1 do
	vim.keymap.set('n', string.format('<leader>%d', i), function() require 'bufferline'.go_to(i, true) end)
end


--[[
local keybinds = {
	-- ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
	-- ["e"] = { "<cmd>NvimTreeToggle<CR>", "Open file tree" },
	--["s"] = {
		name = "Search",
		t = { telescope.live_grep, "Text" },
		f = { telescope.current_buffer_fuzzy_find, "Current buffer" }
	},
--[[	
	["l"] = {
		name = "Lsp",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { telescope.diagnostics, "Buffer Diagnostics" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	},]]
-- }]]--
--local vkeybinds = {
-- ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
--}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- require('telescope').setup
