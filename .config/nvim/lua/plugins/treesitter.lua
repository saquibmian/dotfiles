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
				modules = {},
				ignore_install = {},
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
				-- This is the config for nvim-treesitter-textobjects; it's still fairly experimental and needs to be documented
				-- and tested.
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = { query = "@function.outer", desc = "Select outer part of function region" },
							["if"] = "@function.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "V", -- linewise
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[a"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
