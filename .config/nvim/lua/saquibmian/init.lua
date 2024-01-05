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
require("saquibmian.remap")
require("saquibmian.set")

