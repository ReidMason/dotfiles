local colourscheme = "tokyonight"
return {
	{
		'akinsho/bufferline.nvim',
		event = "VeryLazy",
		opts = {}
	},
	{
		-- Nice ui for builtin neovim prompts like rename and code_actions
		'stevearc/dressing.nvim',
		event = "VeryLazy"
	},

	-- NOTE: First, some plugins that don't require any configuration

	-- Git related plugins
	{
		'tpope/vim-fugitive',
		event = "VeryLazy"
	},
	-- 'tpope/vim-rhubarb',

	-- Detect tabstop and shiftwidth automatically
	-- 'tpope/vim-sleuth',

	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{
				'williamboman/mason.nvim', config = true
			},

			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			-- { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
		event = "VeryLazy"
	},
	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		opts = {},
		event = "VeryLazy"
	},
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		event = "VeryLazy",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
					{ buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
				vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
					{ buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
				vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = '[P]review [H]unk' })
			end,
		},
	},
	{
		-- Theme inspired by Atom
		--'navarasu/onedark.nvim',
		'folke/tokyonight.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme(colourscheme)
		end,
	},

	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = false,
				theme = colourscheme,
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		opts = {
			char = '┊',
			show_trailing_blankline_indent = false,
		},
		event = "VeryLazy"
	},

	-- "gc" to comment visual regions/lines
	-- { 'numToStr/Comment.nvim',         opts = {} },
}
