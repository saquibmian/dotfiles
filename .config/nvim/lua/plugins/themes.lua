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
			vim.cmd([[colorscheme zenbones]])
		end,
	},
	{
		"arzg/vim-colors-xcode",
		priority = 1000,
		lazy = false, -- Themes should not be lazy.
	},
	{
		"maxmx03/solarized.nvim",
		priority = 1000,
		lazy = false, -- Themes should not be lazy.
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"rktjmp/lush.nvim",
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "cocopon/iceberg.vim", name = "iceberg" },
}
