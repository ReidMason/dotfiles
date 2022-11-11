-- require("tokyonight").setup({
--     transparent = true,
-- })
-- -- Set theme
-- vim.cmd[[colorscheme onenord]]

require('onedark').setup({
    style = "deep",
    transparent = true,
  colors = {
    grey = "#a1a6b3",
    bg3 = "#474d59",
  },
})
require('onedark').load()

--local colors = require("onenord.colors").load()
--
--require('onenord').setup({
--    disable = {
--        background = true,
--    },
--    custom_highlights = {
--         = { fg = colors.dark_blue },
--    },
--})
