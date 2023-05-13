-- Install lazy.nvim
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

local utils = require("utils.utils")

-- Setup leader key
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false }) -- Prepare leader key
vim.g.mapleader = " "                                                     -- Set leader
vim.g.maplocalleader = ' '                                                -- Set local leader

-- Vim configs
vim.o.undofile = true             -- Save undo history
vim.o.ignorecase = true           -- Case insensitive search
vim.o.smartcase = true            -- Only case sensitive when search has caps
vim.o.termguicolors = true        -- Custom colours
vim.o.updatetime = 250            -- Decrease update time
vim.o.timeout = true              -- Decrease update time
vim.o.timeoutlen = 300            -- Decrease update time
vim.wo.signcolumn = 'yes'         -- Stop window shifting when gutter is present
vim.g.loaded_netrwPlugin = 1      -- Remove netrw
vim.g.loaded_netrw = 1            -- Remove netrw
vim.opt.clipboard = "unnamedplus" -- Use native clipboard
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.number = true         -- Current line number

-- Move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Hilight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
	group = highlight_group,
	pattern = '*',
})

-- Auto format on save
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
vim.api.nvim_create_autocmd("BufWritePre", {
	-- pattern = opts.pattern,
	callback = function()
		vim.lsp.buf.format()
	end,
})

-- Setup lazy.nvim
-- Here we tell lazy.nvim to load the contents of the lua/plugins/init.lua file
require("lazy").setup("plugins", {
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- Setup custom commands
require("utils.commands").setup_commands()

-- Open alpha if the opened file is a directory
-- vim.defer_fn(function()
-- 	local path          = vim.api.nvim_buf_get_name(0)
-- 	local path_is_empty = string.len(string.gsub(path, '%s+', '')) == 0
-- 	if not path_is_empty and utils.is_directory(path) then
-- 		vim.cmd(':Dashboard')
-- 	end
-- end, 0)
