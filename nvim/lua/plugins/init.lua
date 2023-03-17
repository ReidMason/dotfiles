return {
	-- Can't get this working
	-- {
	-- 	"folke/neodev.nvim",
	-- 	config = function()
	-- 		require("neodev").setup()
	-- 	end
	-- },
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.1',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"numToStr/Comment.nvim",
	},
	{
		-- Mutlicursor
		'mg979/vim-visual-multi'
	},
	{
		'windwp/nvim-autopairs',
		opts = {}
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local navic = require("nvim-navic")
			navic.setup {
				icons = {
					File          = " ",
					Module        = " ",
					Namespace     = " ",
					Package       = " ",
					Class         = " ",
					Method        = " ",
					Property      = " ",
					Field         = " ",
					Constructor   = " ",
					Enum          = "練",
					Interface     = "練",
					Function      = " ",
					Variable      = " ",
					Constant      = " ",
					String        = " ",
					Number        = " ",
					Boolean       = "◩ ",
					Array         = " ",
					Object        = " ",
					Key           = " ",
					Null          = "ﳠ ",
					EnumMember    = " ",
					Struct        = " ",
					Event         = " ",
					Operator      = " ",
					TypeParameter = " ",
				},
				highlight = false,
				separator = " > ",
				depth_limit = 0,
				depth_limit_indicator = "..",
				safe_output = true
			}
		end
	}
}
