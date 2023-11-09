return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	event = "VeryLazy",
	opts = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local formatting = null_ls.builtins.formatting
		local lint = null_ls.builtins.diagnostics
		local sources = {
			formatting.prettier,
			formatting.stylua,
			null_ls.builtins.formatting.gofmt,
			null_ls.builtins.formatting.goimports,
			lint.shellcheck,
		}

		-- Autoformatting on save
		local on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({
					group = augroup,
					buffer = bufnr,
				})

				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end

		return {
			debug = false,
			sources = sources,
			on_attach = on_attach,
		}
	end,
}
