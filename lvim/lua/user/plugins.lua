lvim.plugins = {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "simrat39/rust-tools.nvim" },
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup {
        transparent = true,
        lualine = {
          transparent = false,
        },
      }
    end
  },
  -- { "mattn/emmet-vim" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end
  },
  {
    -- Nice ui for builtin neovim prompts like rename and code_actions
    'stevearc/dressing.nvim',
    event = "VeryLazy"
  },
  -- {
  --   "rcarriga/nvim-notify",
  --   config = {
  --     background_colour = "#000000",
  --   }
  -- },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = {
      notify = {
        enabled = false
      },
      messages = {
        enabled = false
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = false
        },
        signature = {
          enabled = false
        },
        hover = {
          enabled = false
        }
      }
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    }
  }
}
