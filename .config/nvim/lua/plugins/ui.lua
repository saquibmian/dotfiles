return {
	{
		-- File icons :)
		"nvim-tree/nvim-web-devicons",
	},
	{
		-- My main file tree. Shows the file tree, but can also toggle showing open buffers by <S-b>.
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>pv",
				function()
					vim.cmd.NvimTreeFindFileToggle()
				end,
				mode = "n",
				desc = "Toggle NvimTree",
			},
		},
		config = function()
			require("nvim-tree").setup({
				diagnostics = {
					enable = true,
					show_on_dirs = true,
				},
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 45,
				},
				renderer = {
					group_empty = true,
					highlight_diagnostics = true,
				},
				filters = {
					dotfiles = false,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = {
					"diagnostics",
				},
				lualine_c = {
					{
						"filename",
						-- color = { fg = "#ffffff" },
						path = 1,
					},
					"lsp_progress",
				},
				lualine_x = {
					function()
						local bufnr = vim.api.nvim_get_current_buf()

						local clients = vim.lsp.get_active_clients({ bufnr })
						if next(clients) == nil then
							return ""
						end

						local c = {}
						for _, client in pairs(clients) do
							table.insert(c, client.name)
						end
						return table.concat(c, "|")
					end,
				},
				lualine_y = {
					"progress",
				},
				lualine_z = {
					"location",
				},
			},
			extensions = {
				"nvim-tree",
				"nvim-dap-ui",
			},
		},
		config = true,
	},
	{
		"arkav/lualine-lsp-progress",
	},
	{
		-- SmartSplits makes working with splits much nicer
		"mrjones2014/smart-splits.nvim",
		build = "./kitty/install-kittens.bash",
		keys = {
			{
				"<A-h>",
				function()
					require("smart-splits").resize_left()
				end,
				mode = "n",
				desc = "Resize left",
			},
			{
				"<A-j>",
				function()
					require("smart-splits").resize_down()
				end,
				mode = "n",
				desc = "Resize down",
			},
			{
				"<A-k>",
				function()
					require("smart-splits").resize_up()
				end,
				mode = "n",
				desc = "Resize up",
			},
			{
				"<A-l>",
				function()
					require("smart-splits").resize_right()
				end,
				mode = "n",
				desc = "Resize right",
			},
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				mode = "n",
				desc = "Move cursor left",
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				mode = "n",
				desc = "Move cursor down",
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				mode = "n",
				desc = "Move cursor up",
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				mode = "n",
				desc = "Move cursor right",
			},
		},
	},
	{
		-- Telescope is a fuzzy file finder, and also provides some helpful tools, like live_grep.
		-- It's seriously amazing.
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- The latest released version is no good, it's very old. Choose latest main.
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				mappings = {
					n = {
						["<c-d>"] = function(bufnr)
							require("telescope.actions").delete_buffer(bufnr)
						end,
					},
				},
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
				find_files = {
					theme = "dropdown",
					layout_config = {
						preview_cutoff = 100000,
						width = 120,
						height = 20,
					},
					-- Format path as "file.txt (path\to\file\)"
					path_display = function(_, path)
						local tail = require("telescope.utils").path_tail(path)
						return string.format("%s %s", tail, path),
							{ { { 1, #tail }, "Constant" }, { { 2, #path }, "TelescopeResultsComment" } }
					end,
				},
				buffers = {
					theme = "dropdown",
					layout_config = {
						preview_cutoff = 100000,
						width = 120,
						height = 20,
					},
				},
				lsp_dynamic_workspace_symbols = {
					previewer = false,
					theme = "dropdown",
					entry_maker = function()
						return require("plugins.custom.telescope-symbol-entry-maker").maker()
					end,
				},
				live_grep = {
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.70,
					},
				},
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				mode = "n",
				desc = "Open fuzzy file finder in Telescope",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				mode = "n",
				desc = "Open buffers list in Telescope",
			},
			{
				"<S-D-f>",
				function()
					require("telescope.builtin").live_grep()
				end,
				mode = "n",
				desc = "Search across the workspace in Telescope",
			},
			{
				"<leader>F",
				function()
					require("telescope.builtin").live_grep()
				end,
				mode = "n",
				desc = "Search across the workspace in Telescope",
			},
			{
				"<leader>T",
				function()
					require("telescope.builtin").lsp_dynamic_workspace_symbols()
				end,
				mode = "n",
				desc = "Find an LSP symbol across the workspace in Telescope",
			},
		},
	},
	{
		"RRethy/vim-illuminate",
		init = function()
			-- This is configure, not setup, so opts doesn't work
			require("illuminate").configure({
				filetypes_denylist = {
					"Outline",
					"NvimTree",
					"Glance",
				},
			})
		end,
	},
	{
		-- Trouble shows diagnostics in a nice UI. It also integrates nicely with TodoComments and Telescope.
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
		keys = {
			{
				"<leader>dd",
				function()
					require("trouble").open("document_diagnostics")
				end,
				mode = "n",
				desc = "Show document diagnostics in Trouble",
			},
			{
				"<leader>wd",
				function()
					require("trouble").open("workspace_diagnostics")
				end,
				mode = "n",
				desc = "Show workspace diagnostics in Trouble",
			},
		},
	},
	{
		-- TodoComments highlights TODO, FIXME, WARN, and BUG comments in different colours.
		-- It also integrates with Trouble to browse these comments workspace-wide.
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlight = {
				-- Override the pattern to allow highlighting TODOs in the style below:
				-- TODO(foo): hello
				-- ^^^^ is highlighted
				keyword = "bg",
				pattern = [[.*<(KEYWORDS)\s*(\(.*\))?:]],
			},
		},
	},
}
