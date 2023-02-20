return {
	"hrsh7th/nvim-cmp",
	dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
	config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
	sources = {
		{name = "nvim_lsp"},
		{name = "luasnip"}
	}
			})
	end
}
