return {
  {
    dir = "~/Documents/repos/md-preview.nvim",
    -- "reidmason/md-preview.nvim",
    cmd = { "OpenMdPreview", "CloseMdPreview" },
    opts = {},
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
