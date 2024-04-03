-- DarkMode switches my theme to darkmode.
function DarkMode()
	vim.api.nvim_set_option("background", "dark")
	vim.cmd([[colorscheme zenbones]])
end

-- LightMode switches my theme to lightmode.
function LightMode()
	vim.api.nvim_set_option("background", "light")
	vim.cmd([[colorscheme zenbones]])
end

return {
	{
		-- My main light theme.
		"HUAHUAI23/nvim-quietlight",
		lazy = false,
		priority = 1000, -- Themes should not be lazy.
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "savq/melange-nvim", priority = 1000, lazy = false },
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		lazy = false, -- Themes should not be lazy.
	},
	{
		"mcchrish/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		priority = 1000,
		lazy = false, -- Themes should not be lazy.
		init = function()
			-- Set this as my current theme. This and the `after` config are require due to a timing issue with NvimTree.
			LightMode()
		end,
	},
	{
		"rktjmp/lush.nvim",
	},
}
