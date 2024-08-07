return {
	-- The following plugins are required for LSP support. See the docs on lsp-zero if you care about how this works.
	-- I am using lsp-zero because it comes with a bunch of OOTB configurations and mappings.
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{
		"folke/neodev.nvim",
		config = true,
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>o", "<cmd>Outline<cr>", desc = "Toggle Outline" },
		},
		config = true,
	},
	{
		"dnlhc/glance.nvim",
		config = true,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
	},
}
