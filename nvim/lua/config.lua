vim.o.termguicolors = true
vim.cmd.colorscheme "catppuccin-mocha"

vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.o.pumheight = 10 -- Set popup menu height this works for autocompletion

vim.opt.undofile = true
-- vim.wo.relativenumber = true
vim.wo.number = true

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"

-- Disable nvim intro
vim.opt.shortmess:append "sI"

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Keep 8 lines above and below cursor
vim.opt.scrolloff = 12

vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 400
vim.opt.undofile = true

-- Disable continuing comment on new line
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  desc = "Disable New Line Comment",
})

-- Generally read .keymap files as C ones
vim.cmd [[autocmd BufNewFile,BufRead *.keymap setfiletype c]]
