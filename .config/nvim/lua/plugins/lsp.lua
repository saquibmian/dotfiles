return {
	{
		-- Treesitter is a very performant code parser with plugins for many languages. It helps with semantic
		-- colourization of your theme.
		-- NOTE: This is _not_ language server support. See the next set of plugins for that.
		"nvim-treesitter/nvim-treesitter",
		version = false, -- latest released version is too old
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				-- These are the language types that I require to be installed by default. Otherwise, I've enabled auto_install,
				-- which will install other treesitter plugins on the fly when a certain filetype is opened.
				-- The first 6 are required.
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"rust",
					"javascript",
					"typescript",
					"go",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
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
}
