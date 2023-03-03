return {
	"akinsho/toggleterm.nvim",
	branch = "main",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 0,
			},
		})
	end,
	cmd = {
		"ToggleTerm",
		"TermExec",
		"ToggleTermToggleAll",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
	},
	keys = [[<c-\>]],
}
