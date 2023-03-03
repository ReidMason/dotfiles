local M = {}

local user_commands = {
	{
		name = "BufferKill",
		fn = function()
			require("utils.utils").buf_kill "bd"
		end
	}
}

function M.setup_commands()
	local common_opts = { force = true }
	for _, cmd in pairs(user_commands) do
		-- local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
		vim.api.nvim_create_user_command(cmd.name, cmd.fn, {})
	end
end

M.setup_commands()

return M
