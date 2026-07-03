---@type LazySpec
return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  opts = {
    diff = {
      layout = "inline",
    },
    explorer = {
      visible_groups = {
        staged = true,
        unstaged = true,
        conflicts = true,
      },
    },
  },
}
