return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast" },
  config = function()
    vim.cmd "let test#strategy = 'vimux'"
  end,
}
