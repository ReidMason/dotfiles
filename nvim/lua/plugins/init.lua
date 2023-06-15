local colourscheme = "tokyonight"
return {
	-- 'tpope/vim-fugitive',
	-- 'tpope/vim-rhubarb',
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
		'akinsho/bufferline.nvim',
		event = "VeryLazy",
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
		event = "VeryLazy",
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
		opts = {
			char = '┊',
			show_trailing_blankline_indent = false,
		}
	},
	-- {
	-- 	-- Adds git releated signs to the gutter, as well as utilities for managing changes
	-- 	'lewis6991/gitsigns.nvim',
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- See `:help gitsigns.txt`
	-- 		signs = {
	-- 			add = { text = '+' },
	-- 			change = { text = '~' },
	-- 			delete = { text = '_' },
	-- 			topdelete = { text = '‾' },
	-- 			changedelete = { text = '~' },
	-- 		},
	-- 		on_attach = function(bufnr)
	-- 			vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
	-- 				{ buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
	-- 			vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
	-- 				{ buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
	-- 			vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
	-- 				{ buffer = bufnr, desc = '[P]review [H]unk' })
	-- 		end,
	-- 	},
	-- },
}
