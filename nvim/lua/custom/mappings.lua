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
    -- Pane navigation
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "Window left" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "Window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "Window up" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "Window right" },

    -- Telescope binds
    ["<leader>sf"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>st"] = { "<cmd> Telescope live_grep <CR>", "Search text" },
    ["<leader>sd"] = { "<cmd> Telescope diagnostics <CR>", "Find references" },
    ["gd"] = { "<cmd> Telescope lsp_definitions <CR>", "Find definition" },
    ["gr"] = { "<cmd> Telescope lsp_references <CR>", "Find references" },

    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    ["<leader>w"] = { "<cmd> w! <CR>", "Save" },
    ["<leader>qq"] = { "<cmd> confirm qa <CR>", "Quit" },

    -- Lsp commands
    ["<leader>la"] = { vim.lsp.buf.code_action, "LSP code action" },
    ["<leader>lr"] = { vim.lsp.buf.rename, "LSP rename" },

    ["Ss"] = { "<cmd> lua require('persistence').load() <cr>", "Reload last session" },

    ["<leader>E"] = { "<cmd> NvimTreeToggle <CR>", "Close nvimtree" },

    ["<leader>a"] = { "<cmd> lua require('harpoon.mark').add_file() <CR>", "Harpoon file" },
    ["<C-e>"] = { "<cmd> lua require('harpoon.ui').toggle_quick_menu() <CR>", "Toggle Harpon quick menu" },

    ["<M-k>"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
}

return M
