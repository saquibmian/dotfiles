-- These are my personal VIM options.
vim.g.mapleader = " " -- Override the leader from <\> to <Space>. This can cause some issues, but so far I like it.
vim.g.maplocalleader = " "

vim.opt.showmode = false

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
vim.opt.textwidth = 100
vim.opt.colorcolumn = "100"
-- NOTE: Check `after/ftplugin` for options specific to filetypes.

-- Use ripgrep instead of grep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Folding based on Treesitter
-- Use `za` to toggle, `zc` to close, and `zo` to open folds.
-- Use `zR` to open all folds, `zM` to close all folds.
-- Use `zA` to toggle all subfolds.
vim.opt.foldmethod = "expr" -- Use expr for folding. See next line for the expression.
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use LSP for folding.
vim.opt.foldtext = "" -- Enable syntax highlighting on the fold itself.
vim.opt.foldlevel = 99 -- Don't close any folds by default.

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
-- Load and configure plugins from the "plugins" module.
require("lazy").setup("plugins")
