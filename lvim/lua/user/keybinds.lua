-- Bufferline tab switching
for i = 0, 9 do
  local bind = string.format("<leader>%d", i)
  local command = string.format(":BufferLineGoToBuffer %d<CR>", i)
  lvim.keys.normal_mode[bind] = command
end

-- Hide highlight on esc
lvim.keys.normal_mode["<esc>"] = ":noh<CR>"

-- Use telescope to find definitions if there are multple
lvim.lsp.buffer_mappings.normal_mode['gd'] = nil
lvim.keys.normal_mode["gd"] = require('telescope.builtin').lsp_definitions

-- Show error messages in floating window
lvim.keys.normal_mode["<C-k>"] = "<cmd>lua vim.diagnostic.open_float()<CR>"

-- Override list references
lvim.lsp.buffer_mappings.normal_mode['gr'] = nil
lvim.keys.normal_mode["gr"] = require('telescope.builtin').lsp_references
