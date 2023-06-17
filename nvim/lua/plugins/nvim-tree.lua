local icons = require("utils.icons")

return {
	'nvim-tree/nvim-tree.lua',
	-- enabled = false,
	dependencies = {
		'nvim-tree/nvim-web-devicons'
	},
	-- cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
	init = function()
		vim.keymap.set('n', '<leader>e', "<cmd> NvimTreeToggle<CR>")
	end,
	opts = {
		diagnostics = {
			enable = true,
			show_on_dirs = true,
		},
		view = {
			preserve_window_proportions = true,
			adaptive_size = false
		},
		actions = {
			open_file = {
				resize_window = true
			}
		},
		renderer = {
			icons = {
				glyphs = {
					git = {
						unstaged = icons.git.FileUnstaged,
						staged = icons.git.FileStaged,
						unmerged = icons.git.FileUnmerged,
						renamed = icons.git.FileRenamed,
						untracked = icons.git.FileUntracked,
						deleted = icons.git.FileDeleted,
						ignored = icons.git.FileIgnored,
					}
				}
			}
		}
	}
}
