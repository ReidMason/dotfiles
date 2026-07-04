---@type LazySpec
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    fast_wrap = {},
    disable_filetype = { "snacks_input", "vim" },
  },
}
