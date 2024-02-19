return {
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
			format_on_save = {
				async = false,
				timeout_ms = 500,
				lsp_fallback = true,
			},
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
}
