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
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return {
					-- Async false is the default, but set this explicitly because async will make your life very hard.
					async = false,
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- This hooks into formatting via VIM's default <=> keybinding.
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
	},
}
