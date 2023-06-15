local source_names = {
	nvim_lsp = "(LSP)",
	path = "(Path)",
	luasnip = "(Snippet)",
	buffer = "(Buffer)",
	treesitter = "(TreeSitter)",
}

local duplicates = {
	nvim_lsp = 0,
	buffer = 1,
	path = 1,
	luasnip = 1,
}

local icons = require("utils.icons")

return {
	-- Autocompletion
	'hrsh7th/nvim-cmp',
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',

		-- Adds LSP completion capabilities
		'hrsh7th/cmp-nvim-lsp',

		-- Adds a number of user-friendly snippets
		'rafamadriz/friendly-snippets',

		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
	},
	event = { "InsertEnter", "CmdlineEnter" },
	config = function()
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'
		local cmp_window = require('cmp.config.window')

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp_window.bordered(),
				documentation = cmp_window.bordered(),
			},
			mapping = cmp.mapping.preset.insert {
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete {},
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				duplicates_default = 0,
				format = function(entry, vim_item)
					-- Truncate text
					local max_width = 0
					if max_width ~= 0 and #vim_item.abbr > max_width then
						vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) ..
						    icons.ui.Ellipsis
					end

					-- Add icon for kind of suggestion
					vim_item.kind = icons.kind[vim_item.kind]

					-- Add specific icons depending on the source
					if entry.source.name == "crates" then
						vim_item.kind = icons.misc.Package
						vim_item.kind_hl_group = "CmpItemKindCrate"
					end

					-- Add custom source name and dupe priority order
					vim_item.menu = source_names[entry.source.name]
					vim_item.dup = duplicates[entry.source.name] or 0
					return vim_item
				end
			},
			sources = {
				{
					name = "nvim_lsp",
					entry_filter = function(entry, ctx)
						local kind = require("cmp.types.lsp").CompletionItemKind
						    [entry:get_kind()]
						if kind == "Snippet" and ctx.prev_context.filetype == "java" then
							return false
						end
						if kind == "Text" then
							return false
						end
						return true
					end,
				},
				{ name = "path" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "treesitter" },
				{ name = "crates" },
			},
		}
	end
}
