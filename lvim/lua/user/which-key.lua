-- Use which-key to add extra bindings with the leader-key prefix

lvim.builtin.which_key.setup = {
  ignore_missing = true -- Hide mappings that don't have a label
}

-- Binds for persistence
lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  s = { "<cmd>lua require('persistence').load()<cr>", lvim.icons.ui.History .. " Reload last session for dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", lvim.icons.ui.History .. " Restore last session" },
  q = { "<cmd>lua require('persistence').stop()<cr>", lvim.icons.ui.Close .. " Quit without saving session" },
}

-- Use telescope files instead of git files
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<CR>", "Find files" }

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
