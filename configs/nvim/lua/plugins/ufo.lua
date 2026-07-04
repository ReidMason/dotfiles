local skip_filetypes = {
  bigfile = true,
  alpha = true,
  dashboard = true,
  gitcommit = true,
  gitrebase = true,
  help = true,
  lazy = true,
  notify = true,
  oil = true,
  spectre_panel = true,
  startify = true,
  toggleterm = true,
  trouble = true,
}

local function fold_virt_text_handler(virt_text, lnum, end_lnum, width, truncate)
  local chunks = {}
  local suffix = (" 󰁂 %d "):format(end_lnum - lnum)
  local suffix_width = vim.fn.strdisplaywidth(suffix)
  local target_width = width - suffix_width
  local current_width = 0

  for _, chunk in ipairs(virt_text) do
    local text = chunk[1]
    local text_width = vim.fn.strdisplaywidth(text)
    if target_width > current_width + text_width then
      chunks[#chunks + 1] = chunk
    else
      text = truncate(text, target_width - current_width)
      chunks[#chunks + 1] = { text, chunk[2] }
      text_width = vim.fn.strdisplaywidth(text)
      if current_width + text_width < target_width then
        suffix = suffix .. (" "):rep(target_width - current_width - text_width)
      end
      break
    end
    current_width = current_width + text_width
  end

  chunks[#chunks + 1] = { suffix, "UfoFoldedEllipsis" }
  return chunks
end

---@type LazySpec
return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "kevinhwang91/promise-async" },
  opts = {
    open_fold_hl_timeout = 150,
    fold_virt_text_handler = fold_virt_text_handler,
    provider_selector = function(_, filetype, buftype)
      if buftype ~= "" then
        return ""
      end
      if skip_filetypes[filetype] then
        return ""
      end
      return { "treesitter", "indent" }
    end,
  },
  config = function(_, opts)
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.g.markdown_folding = 1
    vim.opt.fillchars:append {
      fold = " ",
      foldopen = "",
      foldsep = " ",
      foldclose = "",
    }

    require("ufo").setup(opts)
  end,
}
