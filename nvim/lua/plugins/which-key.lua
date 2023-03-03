return {
	"folke/which-key.nvim",
	config = function()
		local telescope = require('telescope.builtin')
		local whichkey = require("which-key")

		local keybinds = {
			["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
			["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
			["e"] = { "<cmd>NvimTreeToggle<CR>", "Open file tree" },
			["w"] = { "<cmd>w!<CR>", "Save" },
			["q"] = { "<cmd>confirm q<CR>", "Quit" },
			["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
			["f"] = { telescope.find_files, "Find files" },
			["b"] = { telescope.buffers, "Open buffers" },
			["s"] = {
				name = "Search",
				t = { "<cmd>Telescope live_grep<cr>", "Text" }
			},
			["1"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "First buffer" },
			["2"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "Second buffer" },
			["3"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "Third buffer" },
			["4"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "Fourth buffer" },
			["5"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "Fifth buffer" },
			["6"] = { "<cmd>BufferLineGoToBuffer 6<CR>", "Sixth buffer" },
			["7"] = { "<cmd>BufferLineGoToBuffer 7<CR>", "Seventh buffer" },
			["8"] = { "<cmd>BufferLineGoToBuffer 8<CR>", "Eighth buffer" },
			["9"] = { "<cmd>BufferLineGoToBuffer 9<CR>", "Ninth buffer" },
			["0"] = { "<cmd>BufferLineGoToBuffer 0<CR>", "Tenth buffer" }
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
