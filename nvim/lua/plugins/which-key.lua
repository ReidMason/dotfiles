return {
	--vim.lsp.but.format()
	"folke/which-key.nvim",
	config = function()
		local keybinds = {
			["w"] = { "<cmd>w!<CR>", "Save" },
			["q"] = { "<cmd>confirm q<CR>", "Quit" },
			["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
			["f"] = { "<cmd>Telescope find_files<CR>", "Find files" },
			["b"] = { "<cmd>Telescope buffers<CR>", "Open buffers" }
		}
		local opts = { mode = "n", prefix = "<leader>" }
		require("which-key").register(keybinds, opts)
	end
}
