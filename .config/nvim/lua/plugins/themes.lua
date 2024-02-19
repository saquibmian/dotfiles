-- DarkMode switches my theme to darkmode.
function DarkMode()
	vim.api.nvim_set_option("background", "dark")
	vim.cmd([[colorscheme vscode]])
end

-- LightMode switches my theme to lightmode.
function LightMode()
	vim.api.nvim_set_option("background", "light")
	vim.cmd([[colorscheme quietlight]])
end

return {
	{
		-- My main light theme.
		"HUAHUAI23/nvim-quietlight",
		lazy = false,
		priority = 1000, -- Themes should not be lazy.
		init = function()
			-- Set this as my current theme. This and the `after` config are require due to a timing issue with NvimTree.
			LightMode()
		end,
	},
	{
		-- My main dark theme. I don't particularly like it, I want to place with rosepine.
		"martinsione/darkplus.nvim",
		priority = 1000,
		lazy = false, -- Themes should not be lazy.
	},
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
	},
	{
		"rktjmp/lush.nvim",
	},
}
