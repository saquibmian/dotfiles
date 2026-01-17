return {
	{
		-- GitLinker adds a keymap to generate VCS links to GitHub/BitBucket/etc. for the highlighted lines.
		-- The keymap is <leader>gy.
		"ruifm/gitlinker.nvim",
		config = true,
	},
	{
		-- Fugitive is a _magical_ tool to work with Git. See `:Git` and `:Git commit`.
		-- Also:
		-- - :Gw writes and adds to Git
		"tpope/vim-fugitive",
	},
	{
		-- Gitsigns shows Git change markers in statusline.
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)
			end,
		},
	},
}
