-- Install lazy.nvim our packagemanager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key to space
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " " 

-- Make vim use the native clipboard so vim and the machine share the same clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- Setup lazy.nvim
-- Here we tell lazy.nvim to load the contents of the lua/plugins/init.lua file
require("lazy").setup("plugins")
