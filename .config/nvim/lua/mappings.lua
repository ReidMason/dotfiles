local mappings = {}

mappings.general = {
  n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    ["<leader>w"] = { "<cmd> w! <CR>", "Save" },
    ["<leader>qq"] = { "<cmd> confirm qa <CR>", "Quit" },
    ["<C-a>"] = { "ggVG", "Select all" },
    ["<leader>e"] = {
      function()
        require("oil").toggle_float()
      end,
      "Toggle nvimtree",
    },

    ["<leader>tr"] = { "<cmd> TestNearest <CR>" },
    ["<leader>tf"] = { "<cmd> TestFile <CR>" },

    -- Center buffer while navigating
    ["<C-u>"] = { "<C-u>zz" },
    ["<C-d>"] = { "<C-d>zz" },
    ["{"] = { "{zz" },
    ["}"] = { "}zz" },
    ["N"] = { "Nzz" },
    ["n"] = { "nzz" },
    ["G"] = { "Gzz" },
    ["gg"] = { "ggzz" },
    ["<C-i>"] = { "<C-i>zz" },
    ["<C-o>"] = { "<C-o>zz" },
    ["%"] = { "%zz" },
    ["*"] = { "*zz" },
    ["#"] = { "#zz" },

    ["L"] = { "$" },
    ["H"] = { "^" },
  },
  x = {
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

mappings.copilot = {
  i = {
    ["<C-l>"] = {
      function()
        require("copilot.suggestion").next()
      end,
      "Copilot trigger",
      {},
    },
  },
  n = {
    ["<C-l>"] = {
      function()
        require("copilot.suggestion").next()
      end,
      "Copilot trigger",
      {},
    },
  },
}

mappings.dap = {
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line" },
    ["<leader>dc"] = { "<cmd> DapContinue <CR>", "Dap continue" },
    ["<leader>do"] = { "<cmd> DapStepOver <CR>", "Dap step over" },
    ["<leader>di"] = { "<cmd> DapStepInto <CR>", "Dap step i" },
  },
}

mappings.mdPreview = {
  n = {
    ["<C-b>"] = { "<cmd>OpenMdPreview<CR>", "Open markdown preview" },
  },
}

mappings.dapui = {
  n = {
    ["<leader>dt"] = {
      function()
        require("dapui").toggle()
      end,
      "Open debugging sidebar",
    },
  },
}

mappings.vim = {
  n = {
    ["<leader>sv"] = { "<cmd>vsplit<CR>" },
    ["<leader>sh"] = { "<cmd>split<CR>" },
    ["<leader>sc"] = { "<C-w>c" },
  },
}

mappings.rename = {
  n = {
    ["<leader>lr"] = { ":IncRename ", "LSP rename" },
  },
}

mappings.lsp = {
  n = {
    ["<leader>la"] = { vim.lsp.buf.code_action, "LSP code action" },
    -- ["<leader>lr"] = { vim.lsp.buf.rename, "LSP rename" },

    ["<leader>ld"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
    ["K"] = { vim.lsp.buf.hover, "Lsp info" },
  },
}

mappings.tmuxNavigator = {
  n = {
    ["<M-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "Tmux navigate left" },
    ["<M-j>"] = { "<cmd> TmuxNavigateDown <CR>", "Tmux navigate down" },
    ["<M-k>"] = { "<cmd> TmuxNavigateUp <CR>", "Tmux navigate up" },
    ["<M-l>"] = { "<cmd> TmuxNavigateRight <CR>", "Tmux navigate right" },
  },
}

mappings.harpoon = {
  n = {
    ["<leader>a"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():add()
      end,
      "Harpoon file",
    },
    ["<C-e>"] = {
      function()
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "Toggle Harpon quick menu",
    },
  },
}

-- Switch between buffers
for i = 1, 9, 1 do
  mappings.harpoon.n[string.format("<leader>%s", i)] = {
    function()
      local harpoon = require "harpoon"
      harpoon:list():select(i)
    end,
    "Goto buffer",
  }
end

mappings.telescope = {
  n = {
    ["<leader>sf"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>st"] = { "<cmd> Telescope live_grep <CR>", "Search text" },
    ["<leader>sd"] = { "<cmd> Telescope diagnostics <CR>", "Open diagnostics" },
    ["gd"] = { "<cmd> Telescope lsp_definitions <CR>", "Find definition" },
    ["gt"] = { "<cmd> Telescope lsp_type_definitions <CR>", "Find type definition" },
    ["gr"] = { "<cmd> Telescope lsp_references <CR>", "Find references" },
    ["gi"] = { "<cmd> Telescope lsp_implementations <CR>", "Find references" },
  },
}

mappings.comment = {
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

mappings.lazygit = {
  n = {
    ["<leader>gg"] = { "<cmd> LazyGit <CR>", "Lazygit" },
  },
}

-- Add keybinds
for _, modes in pairs(mappings) do
  for mode, values in pairs(modes) do
    for keybind, mapping_info in pairs(values) do
      local opts = { desc = mapping_info[2] }
      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end
end

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

return mappings
