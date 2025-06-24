return {
	{
		-- File icons :)
		"nvim-tree/nvim-web-devicons",
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
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
					require("trouble").open({
						mode = "diagnostics",
						filter = { buf = 0 },
					})
				end,
				mode = "n",
				desc = "Show document diagnostics in Trouble",
			},
			{
				"<leader>wd",
				function()
					require("trouble").open({ mode = "diagnostics" })
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
				-- ^^^^^^^^^ is highlighted
				-- NOTE: This is a vimgrep regex.
				pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
				keyword = "bg",
			},
			search = {
				-- NOTE: This is a ripgrep regex.
				pattern = [[\b(KEYWORDS)(\(.*\))*:]],
			},
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				layout = {
					preset = "select",
				},
				formatters = {
					file = {
						filename_first = true, -- display filename before the file path
						truncate = 80, -- truncate the file path to (roughly) this length
					},
				},
			},
		},
		keys = {
			{
				"<D-o>",
				function()
					require("snacks").picker.files({
						preset = "select",
					})
				end,
				mode = "n",
				desc = "Open fuzzy file finder in Telescope",
			},
			{
				"<S-D-f>",
				function()
					require("snacks").picker.grep({
						layout = "vertical",
					})
				end,
				mode = "n",
				desc = "Search across the workspace in Telescope",
			},
			{
				"<S-D-o>",
				function()
					require("snacks").picker.buffers({
						preset = "select",
						win = {
							input = {
								keys = {
									["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
								},
							},
							list = { keys = { ["dd"] = "bufdelete" } },
						},
					})
				end,
				mode = "n",
				desc = "Open buffers list in Telescope",
			},
			{
				"<D-p>",
				function()
					require("snacks").picker.lsp_workspace_symbols({
						preset = "select",
					})
				end,
				mode = "n",
				desc = "Find an LSP symbol across the workspace in Telescope",
			},
			{
				"<S-D-p>",
				function()
					require("snacks").picker.lsp_symbols({
						layout = "vscode",
						focus = "list",
						filter = {
							go = {
								"Class",
								"Constructor",
								"Enum",
								-- "Field",
								"Function",
								"Interface",
								"Method",
								"Module",
								"Namespace",
								"Package",
								-- "Property",
								"Struct",
								"Trait",
							},
						},
					})
				end,
				mode = "n",
				desc = "Find an LSP symbol across the workspace in Telescope",
			},
			{
				"\\g",
				function()
					require("snacks").lazygit.open()
				end,
				mode = "n",
				desc = "Open LazyGit",
			},
		},
	},
}
