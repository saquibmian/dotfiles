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
		config = true,
	},
}
