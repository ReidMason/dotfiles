local mappings = {
	n = {
		["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

		["<leader>w"] = { "<cmd> w! <CR>", "Save" },
		["<leader>qq"] = { "<cmd> confirm qa <CR>", "Quit" },
		["<C-a>"] = { "ggVG", "Select all" },
		["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

		-- Harpoon
		["<leader>a"] = { "<cmd> lua require('harpoon.mark').add_file() <CR>", "Harpoon file" },
		["<C-e>"] = { "<cmd> lua require('harpoon.ui').toggle_quick_menu() <CR>", "Toggle Harpon quick menu" },

		-- Telescope
		["<leader>sf"] = { "<cmd> Telescope find_files <CR>", "Find files" },
		["<leader>st"] = { "<cmd> Telescope live_grep <CR>", "Search text" },
		["<leader>sd"] = { "<cmd> Telescope diagnostics <CR>", "Open diagnostics" },
		["gd"] = { "<cmd> Telescope lsp_definitions <CR>", "Find definition" },
		["gr"] = { "<cmd> Telescope lsp_references <CR>", "Find references" },

		-- Tmux navigation
		["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "Window left" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "Window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "Window up" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "Window right" },
	},
	x = {
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
	},
}

-- vim.g.mapleader = " " -- Set <space> as leader key
-- vim.keymap.set("n", "<leader>-", vim.cmd.Ex)

for mode, values in pairs(mappings) do
	for keybind, mapping_info in pairs(values) do
		local opts = { desc = mapping_info[2] }
		vim.keymap.set(mode, keybind, mapping_info[1], opts)
	end
end

-- Switch between buffers
for i = 1, 9, 1 do
	vim.keymap.set("n", string.format("<leader>%s", i), function()
		-- vim.api.nvim_set_current_buf(vim.t.bufs[i])
		require("harpoon.ui").nav_file(i)
	end)
end

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
