-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Switch between buffers
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<leader>%s", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_augroup("diagnostics", { clear = true })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = "diagnostics",
  callback = function()
    vim.diagnostic.setloclist { open = false }
  end,
})

-- Settings
vim.o.termguicolors = true -- Enable advanced terminal colours
vim.opt.guifont = "JetBrainsMono Nerd Font Mono" -- Set font
