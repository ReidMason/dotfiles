return {
	"folke/tokyonight.nvim",
	config = function()
		local tokyonight = require("tokyonight")
		tokyonight.setup({
			style = "moon",
		})
		tokyonight.load()
	end
}

-- return {
-- 	"navarasu/onedark.nvim",
-- 	config = function()
-- 		local onedark = require("onedark")
-- 		onedark.setup({
-- 			transparent = true,
-- 			-- Lualine options --
-- 			lualine = {
-- 				transparent = true, -- lualine center bar transparency
-- 			},
-- 		})
-- 		onedark.load()
-- 	end
-- }
