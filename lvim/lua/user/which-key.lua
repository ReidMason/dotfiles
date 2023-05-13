-- Use which-key to add extra bindings with the leader-key prefix
-- Use telescope files instead of git files
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<CR>", "Find files" }

-- Bufferline tab switching
lvim.builtin.which_key.mappings["1"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "First buffer" }
lvim.builtin.which_key.mappings["2"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "Second buffer" }
lvim.builtin.which_key.mappings["3"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "Third buffer" }
lvim.builtin.which_key.mappings["4"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "Fourth buffer" }
lvim.builtin.which_key.mappings["5"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "Fifth buffer" }
lvim.builtin.which_key.mappings["6"] = { "<cmd>BufferLineGoToBuffer 6<CR>", "Sixth buffer" }
lvim.builtin.which_key.mappings["7"] = { "<cmd>BufferLineGoToBuffer 7<CR>", "Seventh buffer" }
lvim.builtin.which_key.mappings["8"] = { "<cmd>BufferLineGoToBuffer 8<CR>", "Eighth buffer" }
lvim.builtin.which_key.mappings["9"] = { "<cmd>BufferLineGoToBuffer 9<CR>", "Ninth buffer" }
lvim.builtin.which_key.mappings["0"] = { "<cmd>BufferLineGoToBuffer 0<CR>", "Tenth buffer" }

-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
