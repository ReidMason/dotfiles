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
      { "haskell-language-server" },
      { "fourmolu" },

      --{ "lua-language-server" },
      --{ "bash-language-server" },
      --{ "vim-language-server" },
      --{ "editorconfig-checker" },
      --{ "html-lsp" },
      --{ "css-lsp" },mason
      --{ "json-lsp" },
      --{ "eslint_d" },
      --{ "eslint-lsp" },
    },
    run_on_start = true,
  },
  config = function(_, opts)
    local mason_tool_installer = require "mason-tool-installer"
    mason_tool_installer.setup(opts)
    mason_tool_installer.run_on_start()
  end,
}
