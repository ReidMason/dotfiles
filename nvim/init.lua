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

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false }) -- Prepare leader key
vim.g.mapleader = " " -- Set leader
vim.g.maplocalleader = ' ' -- Set local leader

-- Auto format on save
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
vim.api.nvim_create_autocmd("BufWritePre", {
	-- pattern = opts.pattern,
	callback = function()
		vim.lsp.buf.format()
	end,
})

vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case insensitive search
vim.o.smartcase = true -- Only case sensitive when search has caps
vim.wo.signcolumn = 'yes' -- Stop window shifting when gutter is present
vim.o.termguicolors = true -- Custom colours

-- Remove netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Hilight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
	group = highlight_group,
	pattern = '*',
})

vim.opt.clipboard = "unnamedplus" -- Use native clipboard
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.number = true -- Current line number

-- Setup lazy.nvim
-- Here we tell lazy.nvim to load the contents of the lua/plugins/init.lua file
require("lazy").setup("plugins", {
	change_detection = { enabled = false }
})

-- Setup custom commands
require("utils.commands").setup_commands()

function is_directory(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "directory" or false
end

-- Open alpha if the opened file is a directory
vim.defer_fn(function()
	local path          = vim.api.nvim_buf_get_name(0)
	local path_is_empty = string.len(string.gsub(path, '%s+', '')) == 0
	if not path_is_empty and is_directory(path) then
		vim.cmd(':Dashboard')
	end
end, 0)
