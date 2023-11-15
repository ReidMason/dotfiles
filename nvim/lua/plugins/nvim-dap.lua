local mappings = require "mappings"

return {
  {
    "mfussenegger/nvim-dap",
    init = function()
      local sign = vim.fn.sign_define

      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })

      -- Visual
      -- UfoFoldedEllipsis
      sign("DapStopped", {
        text = "→",
        texthl = "NeogitDiffAddHighlight",
        linehl = "NeogitDiffAddHighlight",
        numhl = "NeogitDiffAddHighlight",
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = { mappings.dapui.n.keys },
    config = function()
      vim.api.nvim_create_user_command("DapUiClose", function()
        require("dapui").close()
      end, {})

      require("dapui").setup()
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      require("dap-go").setup(opts)
    end,
  },
}
