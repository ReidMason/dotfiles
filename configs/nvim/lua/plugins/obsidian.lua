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
      enabled = false
    },
    legacy_commands = false, -- this will be removed in 4.0.0
    picker = {
      name = "telescope.nvim",
    },
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/Knowledge Base/Knowledge Base",
      },
    },
  },
}
