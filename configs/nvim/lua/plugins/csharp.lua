return {
  "jmederosalvarado/roslyn.nvim",
  lazy = false,
  setup = function()
    require("roslyn").setup {
      dotnet_cmd = "dotnet", -- this is the default
      roslyn_version = "4.8.0-3.23475.7", -- this is the default
      capabilities = require("core.utils").get_capabilities(),
    }
  end,
}
