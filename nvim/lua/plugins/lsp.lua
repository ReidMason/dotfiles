-- Enable the following language servers
-- Add any additional override configuration in the following tables. They will be passed to
-- the `settings` field of the server config.
local servers = {
	gopls = {},
	rust_analyzer = {},
	tsserver = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- These are any commands we want to run when starting up the language server
local on_attach = function()
	-- Lunarvim has this and I think it's in place to only set the binds for the current buffer
	-- local opts = { buffer = bufnr, noremap = true, silent = true }

	local opts = { noremap = true, silent = true }
	local telescope = require("telescope.builtin")
	-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
	-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	-- vim.keymap.set("n", "<space>wl", function()
	--	 print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, opts)
	-- vim.keymap.set("n", "<space>lD", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "gr", telescope.lsp_references, opts)
	-- vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
	-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
	-- vim.keymap.set("n", "<space>li", "<cmd>LspInfo<CR>", opts)
	-- vim.keymap.set("n", "<space>lI", "<cmd>Mason<CR>", opts)
end

return {
	{
		-- This handles the installation and management of lsp, formatting and dap servers
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		config = function()
			require("mason").setup()
		end
	},
	{
		-- Sets up all the language servers
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			'williamboman/mason.nvim',
			'hrsh7th/cmp-nvim-lsp'
		},
		cmd = { "LspInstall", "LspUninstall" },
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers)
			})

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name]
					})
				end
			})
		end
	},
	{
		-- This is the thing that handles the configuration of the LSP client that's built into neovim
		"neovim/nvim-lspconfig",
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		}
	},
}
