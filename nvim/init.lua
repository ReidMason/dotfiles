local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup(
  { { import = "plugins" }, { dir = "~/Documents/repos/md-preview.nvim", lazy = false, opts = {} } },
  {
    defaults = {
      lazy = true,
    },
    change_detection = {
      notify = false,
    },
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "gzip",
          "zip",
          "zipPlugin",
          "tar",
          "tarPlugin",
          "getscript",
          "getscriptPlugin",
          "vimball",
          "vimballPlugin",
          "2html_plugin",
          "logipat",
          "rrhelper",
          "spellfile_plugin",
          "matchit",
        },
      },
    },
  }
)

require "config"
require "mappings"
