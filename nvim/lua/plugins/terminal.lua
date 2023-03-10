return {
	"akinsho/toggleterm.nvim",
	cmd = {
		"ToggleTerm",
		"TermExec",
		"ToggleTermToggleAll",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
	},
	branch = "main",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<M-\>]],
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 0,
			},
		})
	end,
	keys = [[<M-\>]],
}
