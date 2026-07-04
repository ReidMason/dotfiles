---@type LazySpec
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  cmd = { "Obsidian" },
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    frontmatter = {
      enabled = false,
    },
    legacy_commands = false, -- this will be removed in 4.0.0
    ui = {
      -- render-markdown.nvim handles vault UI
      enable = false,
    },
    picker = {
      name = "snacks.picker",
    },
    completion = {
      min_chars = 1,
    },
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/Knowledge Base/Knowledge Base",
      },
    },
  },
}
