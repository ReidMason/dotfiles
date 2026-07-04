---Expand common Obsidian Templater tags when inserting templates via obsidian.nvim.
---Templater itself is an Obsidian app plugin; this covers the small subset used in vault templates.
local M = {}

local TEMPLATER_DATETIME = "YYYY-MM-DD HH:mm"

---@param path string|?
---@return integer|?
local function file_creation_timestamp(path)
  if path == nil or path == "" then
    return nil
  end

  path = vim.fn.fnamemodify(path, ":p")
  local stat = vim.uv.fs_stat(path)
  if not stat then
    return nil
  end

  if stat.birthtime and stat.birthtime.sec and stat.birthtime.sec > 0 then
    return stat.birthtime.sec
  end

  return nil
end

---@param path string|?
---@return integer|?
local function file_modified_timestamp(path)
  if path == nil or path == "" then
    return nil
  end

  path = vim.fn.fnamemodify(path, ":p")
  local stat = vim.uv.fs_stat(path)
  if not stat or not stat.mtime then
    return nil
  end

  return stat.mtime.sec
end

---@param ctx obsidian.TemplateContext
---@return string|?
local function context_path(ctx)
  if ctx.type == "clone_template" and ctx.destination_path then
    return tostring(ctx.destination_path)
  end

  if ctx.partial_note and ctx.partial_note.path then
    return tostring(ctx.partial_note.path)
  end

  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname ~= "" then
    return bufname
  end

  return nil
end

---@param fmt string|?
---@param ts integer
---@return string
local function format_templater_date(fmt, ts)
  local util = require "obsidian.util"
  local format = (fmt == nil or fmt == "") and TEMPLATER_DATETIME or fmt
  return util.format_date(ts, format)
end

---@param text string
---@param pattern string
---@param repl fun(fmt: string|?): string|?
---@return string
local function replace_templater_call(text, pattern, repl)
  return text:gsub(pattern, function(full, fmt)
    local result = repl(fmt ~= "" and fmt or nil)
    return result or full
  end)
end

---@param text string
---@param ctx obsidian.TemplateContext
---@return string
function M.expand(text, ctx)
  local path = context_path(ctx)
  local creation_ts = file_creation_timestamp(path)
  local modified_ts = file_modified_timestamp(path)

  local arg = "%(%s*\"?([^%)]*)\"?%s*%)"
  local creation_tag = "(<%%%s*tp%.file%.creation_date%s*" .. arg .. "%s*%%>)"
  local modified_tag = "(<%%%s*tp%.file%.last_modified_date%s*" .. arg .. "%s*%%>)"
  local now_tag = "(<%%%s*tp%.date%.now%s*" .. arg .. "%s*%%>)"

  text = replace_templater_call(text, creation_tag, function(fmt)
    if not creation_ts then
      vim.notify(
        ("templater_compat: no file creation time for '%s'"):format(path or "?"),
        vim.log.levels.WARN
      )
      return nil
    end
    return format_templater_date(fmt, creation_ts)
  end)

  text = replace_templater_call(text, modified_tag, function(fmt)
    if not modified_ts then
      vim.notify(
        ("templater_compat: no file modification time for '%s'"):format(path or "?"),
        vim.log.levels.WARN
      )
      return nil
    end
    return format_templater_date(fmt, modified_ts)
  end)

  text = replace_templater_call(text, now_tag, function(fmt)
    return format_templater_date(fmt, os.time())
  end)

  return text
end

function M.setup()
  local templates = require "obsidian.templates"
  local substitute = templates.substitute_template_variables

  templates.substitute_template_variables = function(text, ctx)
    text = substitute(text, ctx)
    return M.expand(text, ctx)
  end
end

return M
