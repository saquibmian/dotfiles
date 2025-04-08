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
			local Terminal = require("toggleterm.terminal").Terminal

			-- -- lazygit terminal bound to \-g
			-- local lazygit = Terminal:new({
			-- 	cmd = "lazygit",
			-- 	hidden = true,
			-- })
			-- vim.keymap.set("n", "\\g", function()
			-- 	lazygit:toggle()
			-- end, { noremap = true, silent = true })

			-- sql terminal bound to \-s
			local sql = Terminal:new({
				cmd = "pgcli",
				hidden = true,
			})
			vim.keymap.set("n", "\\s", function()
				sql:toggle()
			end, { noremap = true, silent = true })
		end,
	},
}
