return {
	"navarasu/onedark.nvim",
	config = function()
		local onedark = require("onedark")
		onedark.setup({
			transparent = true,
			-- Lualine options --
			lualine = {
				transparent = true, -- lualine center bar transparency
			},
		})
		onedark.load()
	end
}
