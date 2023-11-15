return {
  "simrat39/rust-tools.nvim",
  ft = "rust",
  dependencies = "neovim/nvim-lspconfig",
  opts = function()
    local install_root_dir = vim.fn.stdpath "data" .. "/mason"
    local extension_path = install_root_dir .. "/packages/codelldb/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = ""
    if vim.loop.os_uname().sysname:find "Windows" then
      liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    elseif vim.fn.has "mac" == 1 then
      liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    else
      liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    end

    return {
      server = {
        capabilities = require("core.utils").get_capabilities(),
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end,
  setup = function(_, opts)
    require("rust-tools").setup(opts)
  end,
}
