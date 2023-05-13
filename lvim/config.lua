-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

reload('user.plugins')      -- Additional Plugins
reload('user.which-key')    -- Whichkey keybinds
reload('user.keybinds')     -- Additional keybinds
reload('user.autocommands') -- Autom commands

-- Set up colourscheme
lvim.colorscheme = "onedark"

-- Setup code folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99


lvim.builtin.terminal.active = true

-- lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
-- lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

lvim.builtin.bufferline.options.numbers =
"ordinal"                                           -- Display buffer numbers on bufferline
vim.opt.formatoptions =
"c"                                                 -- Disable continue comment on new lin
vim.opt.guifont = "JetBrainsMono Nerd Font Mono"    -- Set font
vim.opt.relativenumber = true                       -- Enable relative line numbers
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' } -- Only highlight when pressing f or t

-- lvim.builtin.project.detection_methods = { "pattern", "lsp" }
-- lvim.builtin.project.patterns = {
--   ".git",
--   "package-lock.json",
--   "yarn.lock",
--   "package.json",
--   "requirenets.txt",
--   "cargo.toml"
-- }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

require("lvim.lsp.manager").setup("emmet_ls")

-- Below is the setup for Rust debugging (This is magic, no idea what's going on here)
-- This sets up the debugger, you need to have codelldb installed with mason use the command ":MasonInstall codelldb"
-- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
-- local codelldb_adapter = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = mason_path .. "bin/codelldb",
--     args = { "--port", "${port}" },
--   },
-- }

-- pcall(function()
-- 	require("rust-tools").setup {
-- 		tools = {
-- 			executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
-- 			reload_workspace_from_cargo_toml = true,
-- 			runnables = {
-- 				use_telescope = true,
-- 			},
-- 			inlay_hints = {
-- 				auto = true,
-- 				only_current_line = false,
-- 				show_parameter_hints = false,
-- 				parameter_hints_prefix = "<-",
-- 				other_hints_prefix = "=>",
-- 				max_len_align = false,
-- 				max_len_align_padding = 1,
-- 				right_align = false,
-- 				right_align_padding = 7,
-- 				highlight = "Comment",
-- 			},
-- 			hover_actions = {
-- 				border = "rounded",
-- 			},
-- 			on_initialized = function()
-- 				vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
-- 					pattern = { "*.rs" },
-- 					callback = function()
-- 						local _, _ = pcall(vim.lsp.codelens.refresh)
-- 					end,
-- 				})
-- 			end,
-- 		},
-- 		dap = {
-- 			adapter = codelldb_adapter,
-- 		},
-- 		server = {
-- 			on_attach = function(client, bufnr)
-- 				require("lvim.lsp").common_on_attach(client, bufnr)
-- 				local rt = require "rust-tools"
-- 				vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
-- 			end,
--
-- 			capabilities = require("lvim.lsp").common_capabilities(),
-- 			settings = {
-- 				["rust-analyzer"] = {
-- 					lens = {
-- 						enable = true,
-- 					},
-- 					checkOnSave = {
-- 						enable = true,
-- 						command = "clippy",
-- 					},
-- 				},
-- 			},
-- 		},
-- 	}
-- end)

-- lvim.builtin.dap.on_config_done = function(dap)
--   dap.adapters.codelldb = codelldb_adapter
--   dap.configurations.rust = {
--     {
--       name = "Launch file",
--       type = "codelldb",
--       request = "launch",
--       program = function()
--         return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--       end,
--       cwd = "${workspaceFolder}",
--       stopOnEntry = false,
--     },
--   }
-- end
