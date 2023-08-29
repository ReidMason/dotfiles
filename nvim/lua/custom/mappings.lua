local M = {}

M.disabled = {
  n = {
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
    ["<leader>wk"] = "",
    ["<leader>wK"] = "",
  },
}

M.custom = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "Window left" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "Window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "Window up" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "Window right" },

    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    ["<leader>w"] = { "<cmd> w! <CR>", "Save" },
    ["<leader>qq"] = { "<cmd> confirm qa <CR>", "Quit" },

    ["<leader>sf"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>st"] = { "<cmd> Telescope live_grep <CR>", "Search text" },
    ["<leader>sd"] = { "<cmd> Telescope diagnostics <CR>", "Find references" },

    ["<leader>la"] = { vim.lsp.buf.code_action, "LSP code action" },
    ["<leader>lr"] = { vim.lsp.buf.rename, "LSP rename" },

    ["gd"] = { "<cmd> Telescope lsp_definitions <CR>", "Find definition" },
    ["gr"] = { "<cmd> Telescope lsp_references <CR>", "Find references" },

    ["Ss"] = { "<cmd> lua require('persistence').load() <cr>", "Reload last session" },

    ["<leader>E"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    ["<M-k>"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
}

return M
