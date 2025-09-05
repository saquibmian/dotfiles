return {
	{
		-- File icons :)
		"nvim-tree/nvim-web-devicons",
		lazy = false,
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
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			view_options = {
				show_hidden = true,
			},
			win_options = {
				signcolumn = "yes:2",
			},
		},
		-- Optional dependencies
		-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		keys = {
			{
				"-",
				function()
					require("oil").open()
				end,
				mode = "n",
				desc = "Open Oil",
			},
		},
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = { "stevearc/oil.nvim" },
		config = true,
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
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
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
				"oil",
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
			{
				"\\S",
				function()
					require("snacks").scratch.open({})
				end,
				mode = "n",
				desc = "Open Scratch buffer",
			},
		},
	},
}
