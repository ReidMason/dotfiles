local on_attach = function(client, bufnr)
	local util = require("lspconfig/util")
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	util.load_mappings("lspconfig", { buffer = bufnr })

	if not util.load_config().ui.lsp_semantic_tokens and client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local installed_lsps = { "lua_ls", "gopls" }
local installed_tools = {
	--{ "astro-language-server" },
	--{ "bash-language-server" },
	--{ "lua-language-server" },
	--{ "vim-language-server" },
	{ "stylua" },
	--{ "editorconfig-checker" },
	--{ "html-lsp" },
	--{ "emmet-ls" },
	--{ "css-lsp" },
	--{ "json-lsp" },
	--{ "prettier" },
	--{ "typescript-language-server" },
	--{ "eslint_d" },
	--{ "eslint-lsp" },
	--{ "codelldb" },
	--{ "tailwindcss-language-server" },
}

return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"nvim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = installed_tools,
			run_on_start = true,
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")
			local masonLspConfig = require("mason-lspconfig")

			masonLspConfig.setup({
				ensure_installed = installed_lsps,
			})

			masonLspConfig.setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server)
					lspconfig[server].setup({})
				end,

				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
										[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
									},
									maxPreload = 100000,
									preloadFileSize = 10000,
								},
							},
						},
					})
				end,

				["gopls"] = function()
					lspconfig.gopls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						cmd = { "gopls" },
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						root_dir = util.root_pattern("go.work", "go.mod", ".git"),
						settings = {
							gopls = {
								completeUnimported = true,
								analyses = {
									unusedparams = true,
									usePlaceholders = false,
									unusedvariable = true,
									fieldalignment = true,
									nilness = true,
									shadow = true,
									unusedwrite = true,
								},
							},
						},
					})
				end,
			})
		end,
	},
}
