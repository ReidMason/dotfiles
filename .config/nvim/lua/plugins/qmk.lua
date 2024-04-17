return {
  "codethread/qmk.nvim",
  lazy = false,
  opts = {
    name = "Lily58",
    variant = "zmk",
    auto_format_pattern = "*.keymap",
    comment_preview = {
      symbols = {
        space = " ",
        horz = "─",
        vert = "│",
        tl = "╭",
        tm = "┬",
        tr = "╮",
        ml = "├",
        mm = "┼",
        mr = "┤",
        bl = "╰",
        bm = "┴",
        br = "╯",
      },
    },
    layout = {
      "x x x x x x _ _ _ _ x x x x x x",
      "x x x x x x _ _ _ _ x x x x x x",
      "x x x x x x _ _ _ _ x x x x x x",
      "x x x x x x x _ _ x x x x x x x",
      "_ _ _ x x x x _ _ x x x x _ _ _",
    },
  },
}
