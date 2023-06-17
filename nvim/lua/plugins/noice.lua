return {
	"folke/noice.nvim",
	event = "BufReadPost",
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		-- "rcarriga/nvim-notify",
	},
	opts = {
		notify = {
			enabled = false
		},
		messages = {
			enabled = false
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			progress = {
				enabled = false
			},
			signature = {
				enabled = false
			},
			hover = {
				enabled = false
			}
		}
	},
}
