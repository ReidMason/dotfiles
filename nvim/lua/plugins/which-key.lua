return {
	"folke/which-key.nvim",
	config = function()
		local telescope = require('telescope.builtin')
		local whichkey = require("which-key")

		local keybinds = {
			["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
			["e"] = { "<cmd>NvimTreeToggle<CR>", "Open file tree" },
			["w"] = { "<cmd>w!<CR>", "Save" },
			["q"] = { "<cmd>confirm q<CR>", "Quit" },
			["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
			["f"] = { telescope.find_files, "Find files" },
			["b"] = { telescope.buffers, "Open buffers" },
			["s"] = {
				name = "Search",
				t = { "<cmd>Telescope live_grep<cr>", "Text" }
			}
		}
		local vkeybinds = {
			["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
		}
		local opts = { mode = "n", prefix = "<leader>" }
		local vopts = { mode = "v", prefix = "<leader>" }

		whichkey.register(keybinds, opts)
		whichkey.register(vkeybinds, vopts)
	end
}
