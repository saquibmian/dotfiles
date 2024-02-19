return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		keys = {
			{
				"<F9>",
				":DapToggleBreakpoint<CR>",
				mode = "n",
				desc = "Toggle breakpoint",
			},
			{
				"<F10>",
				":DapStepOver<CR>",
				mode = "n",
				desc = "Step over",
			},
			{
				"<F11>",
				":DapStepInto<CR>",
				mode = "n",
				desc = "Step into",
			},
			{
				"<F12>",
				":DapStepOut<CR>",
				mode = "n",
				desc = "Step out",
			},
			{
				"<F5>",
				function()
					local dap = require("dap")
					local session = dap.session()
					if session == nil then
						dap.continue()
					else
						dap.restart()
					end
				end,
				mode = "n",
				desc = "Start or restart debugging",
			},
			{
				"<S-F5>",
				":DapTerminate<CR>",
				mode = "n",
				desc = "Terminate debug session",
			},
		},
		config = function()
			local dap = require("dap")
			-- adapters
			local install_dir = vim.fn.stdpath("data") .. "/mason"
			dap.adapters.netcoredbg = {
				type = "executable",
				command = install_dir .. "/packages/netcoredbg/netcoredbg",
				args = { "--interpreter=vscode" },
			}
			-- configurations
			dap.configurations.cs = {
				{
					type = "netcoredbg",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
			-- keymaps
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dapui = require("dapui")
			dapui.setup()
			local dap = require("dap")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
	},
}
