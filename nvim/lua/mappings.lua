
local mappings = { n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    ["<leader>w"] = { "<cmd> w! <CR>", "Save" },
    ["<leader>qq"] = {"<cmd> confirm qa <CR>", "Quit" },

    -- Harpoon
["<leader>a"] = { "<cmd> lua require('harpoon.mark').add_file() <CR>", "Harpoon file" },
    ["<C-e>"] = { "<cmd> lua require('harpoon.ui').toggle_quick_menu() <CR>", "Toggle Harpon quick menu" },
}
}

-- vim.g.mapleader = " " -- Set <space> as leader key 
-- vim.keymap.set("n", "<leader>-", vim.cmd.Ex)  

for mode, values in pairs(mappings) do
	for keybind, mapping_info in pairs(values) do
		local opts = { desc = mapping_info[2]         }
			vim.keymap.set(mode, keybind, mapping_info[1], opts)     
	end 
end

