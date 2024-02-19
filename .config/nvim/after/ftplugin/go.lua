vim.api.nvim_create_user_command("DebugGoTest", function()
	require("dapui").toggle()
	require("dap-go").debug_test()
end, {})
