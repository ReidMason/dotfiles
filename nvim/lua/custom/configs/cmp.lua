local original_opts = require "plugins.configs.cmp"

local format_function = function(_, item)
  local icons = require "nvchad.icons.lspkind"
  local icon = icons[item.kind]
  local max_width = 35

  item.kind = icon -- string.format("%s %s", icon, item.kind)
  item.menu = nil -- item.kind
  if max_width ~= 0 and #item.abbr > max_width then
    item.abbr = string.sub(item.abbr, 1, max_width - 1) .. "..."
  end

  return item
end

local options = {
  formatting = {
    format = format_function,
    fields = { "kind", "abbr", "menu" },
  },
  window = {
    completion = {
      scrollbar = true,
    },
  },
}

return vim.tbl_deep_extend("force", original_opts, options)
