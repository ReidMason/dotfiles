return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	cmd = "Telescope",
	init = function()
		vim.keymap.set('n', '<leader>sf', "<cmd> Telescope find_files <CR>", { desc = '[S]earch [F]iles' })
		vim.keymap.set('n', '<leader>st', "<cmd> Telescope live_grep <CR>", { desc = '[S]earch [T]ext' })

		vim.keymap.set('n', '<leader>?', "<cmd> Telescope oldfiles <CR>", { desc = '[?] Find recently opened files' })

		vim.keymap.set('n', '<leader>sh', "<cmd> Telescope help_tags <CR>", { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<leader>sd', "<cmd> Telescope diagnostics <CR>", { desc = '[S]earch [D]iagnostics' })

		vim.keymap.set('n', 'gd', "<cmd> Telescope lsp_definitions <CR>")
		vim.keymap.set('n', 'gr', "<cmd> Telescope lsp_references <CR>")
	end,
	opts = {
		defaults = {
			mappings = {
				i = {
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
			},
		},
	}
}
