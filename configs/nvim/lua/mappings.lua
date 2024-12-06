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

    ["<leader>/"] = {
      "gcc",
      "Toggle comment",
      { remap = true },
    },
  },
  v = {
    ["<leader>/"] = {
      "gc",
      "Toggle comment",
      { remap = true },
    },
  },
  x = {
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
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
    ["<leader>lr"] = {
      function()
        return ":IncRename " .. vim.fn.expand "<cword>"
      end,
      "LSP rename",
      { expr = true },
    },
  },
}

mappings.lsp = {
  n = {
    ["<leader>la"] = { vim.lsp.buf.code_action, "LSP code action" },
    ["<leader>ld"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
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
    ["<C-h>"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(1)
      end,
      "Harpoon 1",
    },
    ["<C-j>"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(2)
      end,
      "Harpoon 2",
    },
    ["<C-k>"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(3)
      end,
      "Harpoon 3",
    },
    ["<C-l>"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(4)
      end,
      "Harpoon 4",
    },
  },
}

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

mappings.snacks = {
  n = {
    ["<leader>gg"] = { "<cmd> lua Snacks.lazygit() <CR>", "Lazygit" },
  },
}

-- Add keybinds
for _, modes in pairs(mappings) do
  for mode, values in pairs(modes) do
    for keybind, mapping_info in pairs(values) do
      local defaultOpts = { desc = mapping_info[2], noremap = true, silent = true }
      local opts = vim.tbl_extend("keep", defaultOpts, mapping_info[3] or {})
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
