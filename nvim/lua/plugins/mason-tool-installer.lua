return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = {
		ensure_installed = {
			--{ "lua-language-server" },
			{ "lua_ls" },
			{ "gopls" },
			{ "stylua" },
			{ "prettier" },
			--{ "astro-language-server" },
			--{ "bash-language-server" },
			--{ "vim-language-server" },
			--{ "editorconfig-checker" },
			--{ "html-lsp" },
			--{ "emmet-ls" },
			--{ "css-lsp" },
			--{ "json-lsp" },
			--{ "typescript-language-server" },
			--{ "eslint_d" },
			--{ "eslint-lsp" },
			--{ "codelldb" },
			--{ "tailwindcss-language-server" },
		},
		run_on_start = true,
	},
	config = function(_, opts)
		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup(opts)
		mason_tool_installer.run_on_start()
	end,
}
