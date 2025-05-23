return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      { "lua_ls" },
      { "gopls" },
      { "stylua" },
      { "prettier" },
      { "codelldb" },
      { "astro-language-server" },
      { "emmet-ls" },
      { "typescript-language-server" },
      { "tailwindcss-language-server" },
      { "fourmolu" },
      { "docker-compose-language-service" },
      { "ansible-language-server" },
      { "ansible-lint" },
      { "vue-language-server" },
      { "rnix-lsp" },
    },
    run_on_start = true,
  },
  config = function(_, opts)
    local mason_tool_installer = require "mason-tool-installer"
    mason_tool_installer.setup(opts)
    mason_tool_installer.run_on_start()
  end,
}
