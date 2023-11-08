return{ 
"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"nvim/nvim-lspconfig",
	},
	config = function()
    require("mason").setup()
    local lspconfig = require("lspconfig")
    local masonLspConfig = require("mason-lspconfig")
    masonLspConfig.setup({
	    ensure_installed = {'lua_ls'}
    })

    masonLspConfig.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
	function(server)
		lspconfig[server].setup({})
	end,


        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        --["rust_analyzer"] = function ()
            --require("rust-tools").setup {}
        --end
    }
	end,
}
