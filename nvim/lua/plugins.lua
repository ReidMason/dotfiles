local status, packer = pcall(require, 'packer')
if (not status) then
	print("Packer is not installed")
	return
end

vim.cmd[[packadd packer.nvim]]

packer.startup(function(use)
    use 'wbthomason/packer.nvim' -- Plugin manager
    use 'navarasu/onedark.nvim'
    use {
        'nvim-lualine/lualine.nvim', -- Statusline
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'neovim/nvim-lspconfig' -- LSP
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- Autocomplete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    -- Filetree 
    use { 'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' } -- optional, for file icons 
    }
end)
