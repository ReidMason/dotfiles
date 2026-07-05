local mappings = {}

local picker_ignore = {
  hidden = true,
  exclude = { "**/.git/**", "**/node_modules/**" },
}

mappings.general = {
  n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    ["<leader>w"] = { "<cmd> w! <CR>", "Save" },
    ["<leader>qq"] = { "<cmd> confirm qa <CR>", "Quit" },
    ["<C-a>"] = { "ggVG", "Select all" },

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

mappings.vim = {
  n = {
    ["<leader>sv"] = { "<cmd>vsplit<CR>" },
    ["<leader>sh"] = { "<cmd>split<CR>" },
    ["<leader>sc"] = { "<C-w>c" },
  },
}

mappings.oil = {
  n = {
    ["<leader>e"] = {
      function()
        require("oil").toggle_float()
      end,
      "Toggle oil",
    },
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
    ["<leader>lh"] = {
      function()
        vim.lsp.buf.hover { border = "rounded" }
      end,
      "LSP hover",
    },
    ["<leader>ld"] = {
      function()
        vim.lsp.buf.signature_help { border = "rounded" }
      end,
      "LSP signature help",
    },
    ["<leader>lf"] = {
      function()
        require("conform").format { async = true, lsp_format = "fallback" }
      end,
      "Format buffer",
    },
    ["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
    ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
  },
  v = {
    ["<leader>lf"] = {
      function()
        require("conform").format { async = true, lsp_format = "fallback", range = true }
      end,
      "Format selection",
    },
  },
}

local function tmux_resize(direction)
  return function()
    if not vim.env.TMUX then
      return
    end
    vim.fn.system("tmux resize-pane -" .. direction .. " 5")
  end
end

local tmux_mappings = {
  ["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "Tmux navigate left" },
  ["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "Tmux navigate down" },
  ["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "Tmux navigate up" },
  ["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "Tmux navigate right" },
  ["<C-S-h>"] = { tmux_resize("L"), "Resize tmux pane left" },
  ["<C-S-j>"] = { tmux_resize("D"), "Resize tmux pane down" },
  ["<C-S-k>"] = { tmux_resize("U"), "Resize tmux pane up" },
  ["<C-S-l>"] = { tmux_resize("R"), "Resize tmux pane right" },
}

mappings.tmuxNavigator = {
  n = tmux_mappings,
  v = tmux_mappings
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
    ["H"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(1)
      end,
      "Harpoon 1",
    },
    ["J"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(2)
      end,
      "Harpoon 2",
    },
    ["K"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(3)
      end,
      "Harpoon 3",
    },
    ["L"] = {
      function()
        local harpoon = require "harpoon"
        harpoon:list():select(4)
      end,
      "Harpoon 4",
    },
  },
}

mappings.snacks = {
  n = {
    ["<leader>H"] = {
      function()
        Snacks.dashboard()
      end,
      "Dashboard",
    },
    ["<leader>sf"] = {
      function()
        Snacks.picker.files(picker_ignore)
      end,
      "Find files",
    },
    ["<leader>st"] = {
      function()
        Snacks.picker.grep(picker_ignore)
      end,
      "Search text",
    },
    ["<leader>sd"] = {
      function()
        Snacks.picker.diagnostics()
      end,
      "Diagnostics",
    },
    ["gd"] = {
      function()
        Snacks.picker.lsp_definitions()
      end,
      "Find definition",
    },
    ["gt"] = {
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      "Find type definition",
    },
    ["gr"] = {
      function()
        Snacks.picker.lsp_references()
      end,
      "Find references",
    },
    ["gi"] = {
      function()
        Snacks.picker.lsp_implementations()
      end,
      "Find implementations",
    },
  },
}

mappings.noice = {
  n = {
    ["<leader>nn"] = { "<cmd> Noice history <CR>", "Noice message history" },
    ["<leader>nl"] = { "<cmd> Noice last <CR>", "Noice last message" },
    ["<leader>ne"] = { "<cmd> Noice errors <CR>", "Noice errors" },
    ["<leader>nd"] = { "<cmd> Noice dismiss <CR>", "Dismiss visible notifications" },
    ["<leader>no"] = { "<cmd> Noice log <CR>", "Open noice log (full errors + stack traces)" },
  },
}

mappings.neogit = {
  n = {
    ["<leader>gg"] = { "<cmd>Neogit<cr>", "Neogit" },
    ["<leader>gc"] = { "<cmd>Neogit commit<cr>", "Neogit commit" },
    ["<leader>gd"] = { "<cmd>DiffviewOpen<cr>", "Diffview" },
  },
}

function mappings.diffview_plugin_keymaps()
  local actions = require("diffview.actions")

  return {
    view = {
      { "n", "q", actions.close, { desc = "Close diffview" } },
      { "n", "g<C-x>", false },
      { "n", "t", actions.cycle_layout, { desc = "Cycle diff layout" } },
    },
    file_panel = {
      { "n", "q", "<cmd>tabclose<cr>", { desc = "Close diffview" } },
      { "n", "g<C-x>", false },
      { "n", "t", actions.cycle_layout, { desc = "Cycle diff layout" } },
    },
    file_history_panel = {
      { "n", "q", "<cmd>tabclose<cr>", { desc = "Close diffview" } },
      { "n", "g<C-x>", false },
      { "n", "t", actions.cycle_layout, { desc = "Cycle diff layout" } },
    },
  }
end

mappings.sidekick = {
  n = {
    ["<leader>ac"] = {
      function()
        require("sidekick.cli").toggle({ name = "cursor", focus = true })
      end,
      "Toggle agent",
    },
    ["<leader>ap"] = {
      function()
        require("sidekick.cli").prompt()
      end,
      "Prompt picker",
    },
    ["<leader>ai"] = {
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      "Send context",
    },
    ["<leader>af"] = {
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      "Send file",
    },
    ["<leader>ad"] = {
      function()
        require("sidekick.cli").close()
      end,
      "Detach agent",
    },
  },
  x = {
    ["<leader>ap"] = {
      function()
        require("sidekick.cli").prompt()
      end,
      "Prompt picker",
    },
    ["<leader>av"] = {
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      "Send selection",
    },
    ["<leader>ai"] = {
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      "Send context",
    },
  },
}

mappings.ufo = {
  n = {
    ["<Tab>"] = { "za", "Toggle fold" },
    ["<leader>zt"] = { "za", "Toggle fold" },
    ["<leader>zc"] = { "zc", "Close fold" },
    ["<leader>zo"] = { "zo", "Open fold" },
    ["<leader>zp"] = {
      function()
        require("ufo").peekFoldedLinesUnderCursor()
      end,
      "Peek fold",
    },
    ["<leader>zR"] = {
      function()
        require("ufo").openAllFolds()
      end,
      "Open all folds",
    },
    ["<leader>zM"] = {
      function()
        require("ufo").closeAllFolds()
      end,
      "Close all folds",
    },
    ["zR"] = {
      function()
        require("ufo").openAllFolds()
      end,
      "Open all folds",
    },
    ["zM"] = {
      function()
        require("ufo").closeAllFolds()
      end,
      "Close all folds",
    },
    ["zp"] = {
      function()
        require("ufo").peekFoldedLinesUnderCursor()
      end,
      "Peek fold",
    },
  },
}

-- Add keybinds
for _, modes in pairs(mappings) do
  if type(modes) == "table" then
    for mode, values in pairs(modes) do
      for keybind, mapping_info in pairs(values) do
        local defaultOpts = { desc = mapping_info[2], noremap = true, silent = true }
        local opts = vim.tbl_extend("keep", defaultOpts, mapping_info[3] or {})
        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end
end

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

return mappings
