return {
	{
		-- ToggleTerm opens a terminal in a floating window.
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = "\\t",
				direction = "float",
			})
			-- lazygit terminal bound to \-g
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
			local function _lazygit_toggle()
				lazygit:toggle()
			end
			vim.keymap.set("n", "\\g", function()
				_lazygit_toggle()
			end, { noremap = true, silent = true })
		end,
	},
}
