-- The configuration for lsp-zero, LSP servers, and autocomplete mappings. See the docs for lsp-zero for more
-- information about what's going on here.
local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(client, bufnr)
	-- enable inlay hints if they're supported by the client
	if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		-- Go to definition
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "<leader>fr", function()
		-- Find all references
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		-- Find all implementations
		vim.lsp.buf.implementation()
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
	vim.keymap.set("n", "<leader><leader>", function()
		-- Trigger code actions
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("v", "<leader><leader>", function()
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
		"buf_ls",
		"html",
		"gopls",
		"ts_ls",
		"rust_analyzer",
		"omnisharp",
		"svelte",
		"lua_ls",
		"omnisharp",
		"rust_analyzer",
		"svelte",
	},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
		buf_ls = function()
			require("lspconfig").buf_ls.setup({
				cmd = { "/Users/saquib/dev/buf/buf", "lsp", "serve", "--timeout=0", "--log-format=text", "--debug" },
			})
		end,
		rust_analyzer = function()
			-- We disable the `neovim/lspconfig`'s rust_analyzer config because we have rustaceanim installed,
			-- and it sets up its own LSP config.
			return true
		end,
		gopls = function()
			local settings = require("plugins.lsp.settings")
			require("lspconfig").gopls.setup({
				settings = {
					gopls = settings.gopls,
				},
			})
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
	formatting = lsp_zero.cmp_format({}),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

function InlayToggle()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
