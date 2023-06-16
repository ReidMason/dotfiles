local colourscheme = "tokyonight"
return {
	{ 'nvim-lua/plenary.nvim' },
	{
		'tpope/vim-fugitive',
		enabled = false
	},
	-- 'tpope/vim-rhubarb',
	{
		"sindrets/diffview.nvim",
		enabled = false
	},
	{
		-- Theme inspired by Atom
		--'navarasu/onedark.nvim',
		'folke/tokyonight.nvim',
		priority = 1000,
		init = function()
			vim.cmd.colorscheme(colourscheme)
		end,
	},
	{
		'akinsho/bufferline.nvim',
		event = "BufReadPost",
		opts = {}
	},
	{
		-- Nice ui for builtin neovim prompts like rename and code_actions
		'stevearc/dressing.nvim',
		event = "VeryLazy"
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" }
	},
	{
		-- Detect tabstop and shiftwidth automatically
		'tpope/vim-sleuth',
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		event = "VeryLazy",
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
		}
	},
	{
		-- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		opts = {},
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
		event = "VeryLazy",
		enabled = false,
		opts = {
			char = '┊',
			show_trailing_blankline_indent = false,
		}
	},
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		-- Gitsigns diffthis
		'lewis6991/gitsigns.nvim',
		enabled = false,
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},
}
