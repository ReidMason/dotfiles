local M = {}

M.keys = {
  {
    "s",
    mode = { "n", "x", "o" },
    function()
      require("flash").jump {
        -- Only jump to the beginning of the word
        search = {
          mode = function(str)
            return "\\<" .. str
          end,
        },
      }
    end,
    desc = "Flash",
  },
  {
    "S",
    mode = { "n", "o", "x" },
    function()
      require("flash").treesitter()
    end,
    desc = "Flash Treesitter",
  },
  {
    "r",
    mode = "o",
    function()
      require("flash").remote()
    end,
    desc = "Remote Flash",
  },
  {
    "R",
    mode = { "o", "x" },
    function()
      require("flash").treesitter_search()
    end,
    desc = "Flash Treesitter Search",
  },
  {
    "<c-s>",
    mode = { "c" },
    function()
      require("flash").toggle()
    end,
    desc = "Toggle Flash Search",
  },
}

M.opts = {
  modes = {
    -- options used when flash is activated through
    -- a regular search with `/` or `?`
    search = {
      enabled = false,
    },
    -- options used when flash is activated through
    -- `f`, `F`, `t`, `T`, `;` and `,` motions
    char = {
      enabled = false,
    },
  },
}

return M
