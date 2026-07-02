---@type LazySpec
return {
  "rmagatti/auto-session",
  event = "VeryLazy",
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_restore = false,
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    session_lens = {
      load_on_setup = false,
    },
  }
}
