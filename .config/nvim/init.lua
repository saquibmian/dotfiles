-- I use the Lazy.nvim package manager. It provides the most flexibile and sane default behaviour.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- These are my personal VIM options.
vim.g.mapleader = " " -- Override the leader from <\> to <Space>. This can cause some issues, but so far I like it.
vim.opt.nu = true -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers.
-- All 4 of these options are set together. For your sanity, the first three should match.
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- Highlight searches as I'm typing, and preview replacements.
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.wrap = false -- Disable wordwrap.
vim.opt.scrolloff = 8 -- Ensure there are always 8 free lines at the bottom of the buffer window.
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50 -- I want fast updates.
-- Show a vertical line at the 120 character mark, to help align text.
vim.opt.colorcolumn = "120"
-- NOTE: Check `after/ftplugin` for options specific to filetypes.

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

-- These are my plugins.
-- TODO: Move these out to a modular structure under `plugins`.
require("lazy").setup({
	{
		-- My main light theme.
		"HUAHUAI23/nvim-quietlight",
		lazy = false,
		priority = 1000, -- Themes should not be lazy.
		init = function()
			-- Set this as my current theme. This and the `after` config are require due to a timing issue with NvimTree.
			-- TODO: there must be better way to do this
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
		lazy = false, -- Themes should not be lazy.
		priority = 1000,
	},
	{
		"folke/neodev.nvim",
		config = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
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
						color = { fg = "#ffffff" },
						path = 1,
					},
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
				"nvim-dap-ui",
			},
		},
		config = true,
	},
	{
		-- SmartSplits makes working with splits much nicer
		"mrjones2014/smart-splits.nvim",
		build = "./kitty/install-kittens.bash",
		init = function()
			vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
			-- moving between splits
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
		end,
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
				layout_strategy = "vertical",
				layout_config = {
					preview_height = 0.70,
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
		},
	},
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
					vim.cmd.NvimTreeToggle()
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
					dotfiles = true,
				},
			})
		end,
	},
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
		-- Some LSPs have builtin formatting, but Conform overrides all of them with much better support for formatting.
		-- For example, you can use prettier instead of the LSP. It can also automatically hook into on_save events and
		-- optionally fallback to the LSP.
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				proto = { "buf" },
				fish = { "fish_indent" },
				go = { "gopls" },
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				sql = { "pg_format" },
			},
			-- Async false is the default, but set this explicitly because async will make your life very hard.
			format_on_save = { async = false, timeout_ms = 500, lsp_fallback = true },
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- This hooks into formatting via VIM's default <=> keybinding.
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		-- ToggleTerm opens a terminal in a floating window.
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = "\\t",
			direction = "float",
		},
		config = true,
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
	{
		-- GitLinker adds a keymap to generate VCS links to GitHub/BitBucket/etc. for the highlighted lines.
		-- The keymap is <leader>gy.
		"ruifm/gitlinker.nvim",
		config = true,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
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
	-- DAP (Debug Adapter Protocol) support
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<F9>", ":DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
		},
		config = function()
			local dap = require("dap")
			-- adapters
			local install_dir = vim.fn.stdpath("data") .. "/mason"
			dap.adapters.netcoredbg = {
				type = "executable",
				command = install_dir .. "/packages/netcoredbg/netcoredbg",
				args = { "--interpreter=vscode" },
			}
			-- configurations
			dap.configurations.cs = {
				{
					type = "netcoredbg",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
			-- keymaps
			-- TODO: move these out to actual keymaps
			vim.keymap.set("n", "<F5>", function()
				local session = dap.session()
				if session == nil then
					dap.continue()
				else
					dap.restart()
				end
			end)
			vim.keymap.set("n", "<F10>", ":DapStepOver<CR>")
			vim.keymap.set("n", "<F11>", ":DapStepInto<CR>")
			vim.keymap.set("n", "<F12>", ":DapStepOut<CR>")
			vim.keymap.set("n", "<S-F5>", ":DapTerminate<CR>")
		end,
		lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dapui = require("dapui")
			dapui.setup()
			local dap = require("dap")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
	},
})

-- The configuration for lsp-zero, LSP servers, and autocomplete mappings. See the docs for lsp-zero for more
-- information about what's going on here.
local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		-- go to definition
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "<leader>fr", function()
		-- find all references
		require("trouble").toggle("lsp_references")
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		-- Find all implementations
		require("trouble").toggle("lsp_implementations")
	end, opts)
	vim.keymap.set("n", "gD", "<CMD>Glance definitions<CR>")
	vim.keymap.set("n", "gR", "<CMD>Glance references<CR>")
	vim.keymap.set("n", "gI", "<CMD>Glance implementations<CR>")
	vim.keymap.set("n", "K", function()
		-- Hover definition
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "[d", function()
		-- Go to previous error
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "]d", function()
		-- Go to next error
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "<C-.>", function()
		-- Trigger code actions
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<F2>", function()
		-- Rename symbol
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		-- Hover signature help
		vim.lsp.buf.signature_help()
	end, opts)
end)
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"bufls",
		"html",
		"gopls",
		"tsserver",
		"rust_analyzer",
		"omnisharp",
		"svelte",
		"lua_ls",
	},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})
