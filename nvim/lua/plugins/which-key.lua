return {
	"folke/which-key.nvim",
	config = function()
		local keybinds = {
			["w"] = { "<cmd>w!<CR>", "Save"},
			["q"] = { "<cmd>confirm q<CR>", "Quit" },
			["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
		} 
		local opts = {mode = "n", prefix = "<leader>"}
		require("which-key").register(keybinds, opts)
	end
}


