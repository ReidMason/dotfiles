local ensure_installed = {
  "bash",
  "css",
  "dockerfile",
  "go",
  "haskell",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "nix",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
      require("nvim-treesitter").install(ensure_installed)

      vim.api.nvim_create_autocmd({ "FileType", "BufReadPost" }, {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = true,
      },
    },
    config = function()
      local sel = require("nvim-treesitter-textobjects.select")
      local map = function(lhs, query, group, desc)
        vim.keymap.set({ "x", "o" }, lhs, function()
          sel.select_textobject(query, group or "textobjects")
        end, { desc = desc })
      end

      map("af", "@function.outer")
      map("if", "@function.inner")
      map("ac", "@class.outer")
      map("ic", "@class.inner", "textobjects", "Select inner part of a class region")
      map("as", "@local.scope", "locals", "Select language scope") -- was @scope on master
    end
  }
}
