---@type LazySpec
return {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  enabled = false,
  opts = {
    filetypes = { "*" },
    user_default_options = {
      names = false,
      tailwind = true,
      css = true,
      css_fn = true,
    },
  },
}
