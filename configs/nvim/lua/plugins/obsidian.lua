---@type LazySpec
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  cmd = { "Obsidian" },
  ft = "markdown",
  ---@module 'obsidian'
  ---@type fun(): obsidian.config
  opts = function()
    ---@type obsidian.config.TemplateOpts
    local templates = vim.tbl_deep_extend("force", require("obsidian.config.default").templates, {
      folder = "005 - Templates",
    })

    return {
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
      templates = templates,
      notes_subdir = "002 - Cortex",
      new_notes_location = "notes_subdir",
      -- Make name input actually name the file instead of using a zettle style name
      note_id_func = require("obsidian.builtin").title_id,
      daily_notes = {
        folder = "002 - Cortex",
        template = "Journal",
        workdays_only = false,
      },
      link = {
        auto_update = true,
      },
      file = {
        ignore_filters = { ".obsidian", ".git" },
      },
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Knowledge Base",
        },
      },
    }
  end,
}
