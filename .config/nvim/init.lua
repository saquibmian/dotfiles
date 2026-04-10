-- These are my personal VIM options.
vim.g.mapleader = " " -- Override the leader from <\> to <Space>. This can cause some issues, but so far I like it.
vim.g.maplocalleader = " "

vim.opt.showmode = false

vim.opt.nu = true             -- Enable line numbers
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
vim.opt.wrap = false    -- Disable wordwrap.
vim.opt.scrolloff = 8   -- Ensure there are always 8 free lines at the bottom of the buffer window.
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50 -- I want fast updates.
-- Show a vertical line at the 100 character mark, to help align text.
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
vim.opt.foldmethod = "expr"                          -- Use expr for folding. See next line for the expression.
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use LSP for folding.
vim.opt.foldtext = ""                                -- Enable syntax highlighting on the fold itself.
vim.opt.foldlevel = 99                               -- Don't close any folds by default.

-- Native autocompletion.
vim.opt.completeopt = "fuzzy,menu,menuone,popup,noinsert"

-- This hooks into formatting via VIM's default <=> keybinding.
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Move selected lines up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Update some things once installed.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})
-- Install plugins
vim.pack.add({
  -- colorschemes, always first
  { src = "https://github.com/rktjmp/lush.nvim" }, -- needed by zenbones
  { src = "https://github.com/mcchrish/zenbones.nvim" },
  { src = "https://github.com/AlexvZyl/nordic.nvim" },

  -- Next, Oil and its deps
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/JezerM/oil-lsp-diagnostics.nvim" },
  { src = "https://github.com/refractalize/oil-git-status.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },

  -- Lualine and its deps
  { src = "https://github.com/arkav/lualine-lsp-progress" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  -- Smartsplits
  { src = "https://github.com/mrjones2014/smart-splits.nvim" },

  -- Git integration
  { src = "https://github.com/nvim-lua/plenary.nvim" }, -- required by gitlinker and todo-comments
  { src = "https://github.com/ruifm/gitlinker.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  -- Toggle term
  { src = "https://github.com/akinsho/toggleterm.nvim" },

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },

  -- Snacks
  { src = "https://github.com/folke/snacks.nvim" },

  -- LSP
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/dnlhc/glance.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },

  -- AI
  { src = "https://github.com/github/copilot.vim" },

  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },

  { src = "https://github.com/mrjones2014/smart-splits.nvim" },
})

-- Set theme
vim.cmd([[colorscheme zenbones]])

require("colorizer").setup()

require("snacks").setup({
  picker = {
    formatters = {
      file = {
        filename_first = true, -- display filename before the file path
        truncate = 80,     -- truncate the file path to (roughly) this length
      },
    },
  },
})
vim.keymap.set("n", "<D-o>", function()
  require("snacks").picker.files({
    layout = "select",
  })
end, { desc = "Open fuzzy file finder in Snacks" })
vim.keymap.set("n", "<S-D-f>", function()
  require("snacks").picker.grep({
    layout = "vertical",
  })
end, { desc = "Search across the workspace in Snacks" })
vim.keymap.set("n", "<S-D-o>", function()
  require("snacks").picker.buffers({
    layout = "select",
    win = {
      input = {
        keys = {
          ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
        },
      },
      list = { keys = { ["dd"] = "bufdelete" } },
    },
  })
end, { desc = "Open buffers list in Snacks" })
vim.keymap.set("n", "<D-p>", function()
  require("snacks").picker.lsp_workspace_symbols({
    layout = "select",
  })
end, { desc = "Find an LSP symbol across the workspace in Snacks" })
vim.keymap.set("n", "<S-D-p>", function()
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
end, { desc = "Find an LSP symbol across the workspace in Snacks" })
vim.keymap.set("n", "\\g", function()
  require("snacks").lazygit.open()
end, { desc = "Open LazyGit" })
vim.keymap.set("n", "\\S", function()
  require("snacks").scratch.open({})
end, { desc = "Open Scratch buffer" })
vim.keymap.set("n", "\\k", function()
  require("snacks").terminal.open("k9s")
end, { desc = "Open Scratch buffer" })

require("todo-comments").setup({
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
})

require("trouble").setup({})

vim.keymap.set("n", "<leader>dd", function()
  require("trouble").open({
    mode = "diagnostics",
  })
end, { desc = "Show document Diagnostics in Trouble" })
vim.keymap.set("n", "<leader>wd", function()
  require("trouble").open({
    mode = "diagnostics",
  })
end, { desc = "Show workspace Diagnostics in Trouble" })

require("gitlinker").setup()
require("gitsigns").setup({
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
})
require("toggleterm").setup({
  open_mapping = "\\t",
  direction = "float",
})
local Terminal = require("toggleterm.terminal").Terminal
local sql = Terminal:new({
  cmd = "pgcli",
  hidden = true,
})
vim.keymap.set("n", "\\s", function() -- sql terminal bound to \-s
  sql:toggle()
end, { noremap = true, silent = true })

local treesitter = require("nvim-treesitter")
local treesitter_languages = {
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "rust",
  "javascript",
  "typescript",
  "go",
}
treesitter.install(treesitter_languages)
vim.api.nvim_create_autocmd("FileType", {
  pattern = treesitter_languages,
  callback = function(ev)
    vim.treesitter.start(ev.buf)
  end,
})
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v", -- charwise
      ["@function.outer"] = "V", -- linewise
      ["@class.outer"] = "V",  -- linewise
    },
  },
  move = {
    set_jumps = true,
  },
})
vim.keymap.set({ "x", "o" }, "aa", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "af", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)

vim.keymap.set("n", "<leader>a", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>A", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end)
vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[m", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)

-- Configure plugins
-- Lualine
require("lualine").setup({
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
      { "filename", path = 1 },
      "lsp_progress",
    },
    lualine_x = {
      function()
        local bufnr = vim.api.nvim_get_current_buf()

        local clients = #vim.tbl_keys(vim.lsp.get_clients({ bufnr }))
        if clients == 0 then
          return ""
        end
        return " " .. clients
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
  },
})
-- Oil
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  win_options = {
    signcolumn = "yes:2",
  },
})
vim.keymap.set("n", "-", function()
  require("oil").open()
end, { desc = "Open parent directory" })
-- Smartsplits
require("smart-splits").setup({})
-- resizing splits
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

-- LSP
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ", -- x000f015a
      [vim.diagnostic.severity.WARN] = "󰀪 ", -- x000f002a
      [vim.diagnostic.severity.INFO] = "󰋽 ", -- x000f02fd
      [vim.diagnostic.severity.HINT] = "󰌶 ", -- x000f0336
    },
  },
  float = {
    source = true,
  },
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = "cursor",
        focus = false,
      })
    end,
  },
})
require("mason").setup()
require("mason-lspconfig").setup() -- enables Mason-set-up LSP servers by default
local lsp_settings = {
  buf_ls = {},
  gopls = {
    settings = {
      gopls = {
        newGoFileHeader = true,
        renameMovesSubpackages = true,
        semanticTokens = true,
        linksInHover = false,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = false,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
      },
    },
  },
  html = {},
  jsonls = {
    settings = {
      json = {
        format = { enabled = false },
        schemas = {
          {
            description = "ESLint config",
            fileMatch = { ".eslintrc.json", ".eslintrc" },
            url = "http://json.schemastore.org/eslintrc",
          },
          {
            description = "Package config",
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package",
          },
          {
            description = "Tasks config",
            fileMatch = { "*tasks*.json" },
            url = "https://json.schemastore.org/task.json",
          },
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        codeLens = {
          enable = true,
        },
        hint = {
          enable = true,
          semicolon = "Disable",
        },
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      },
    },
  },
  omnisharp = {},
  svelte = {},
  yaml = {
    settings = {
      yaml = {
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemas = {
          kubernetes = "*.yaml",
          ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
          ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
          ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
          ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
          "*gitlab-ci*.{yml,yaml}",
          ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
          "*api*.{yml,yaml}",
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
          "*docker-compose*.{yml,yaml}",
        },
        format = { enabled = false },
        validate = false,
        completion = true,
        hover = true,
      },
    },
  },
}
for lsp, config in pairs(lsp_settings) do
  vim.lsp.config(lsp, config)
  vim.lsp.enable(lsp)
end
-- local lsp_setting_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/lsp/*.lua", false, true)
-- for _, file in ipairs(lsp_setting_files) do
--   local module_name = file:match("([^/]+)%.lua$")
--   local settings = require("plugins.lsp." .. module_name)
--   vim.lsp.config(module_name, settings)
--   vim.lsp.enable(module_name)
-- end
require("conform").setup({
  formatters_by_ft = {
    proto = { "buf" },
    fish = { "fish_indent" },
    go = { "gopls" },
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "jq" },
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
      lsp_format = "fallback",
    }
  end,
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2" },
    },
  },
})
-- This adds the FormatDisable and FormatEnable commands to disable and enable
-- autoformat-on-save.
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
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Enable auto-completion.
    if client:supports_method("textDocument/completion") then
      -- Trigger autocompletion on the following keypress, rather than just the LSP's triggerCharacters.
      local chars = {}
      for i = 65, 90 do -- A -> Z
        table.insert(chars, string.char(i))
      end
      for i = 97, 122 do -- a -> z
        table.insert(chars, string.char(i))
      end
      table.insert(chars, ".") -- .
      table.insert(chars, "_")
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get({ bufnr = args.buf, id = client.id })
      end, { buffer = args.buf })
    end

    -- Enable inlay hints if they're supported by the client
    if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    -- Enable highlight
    if client:supports_method("textDocument/documentHighlight") then
      local augroup = vim.api.nvim_create_augroup("lsp-document-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
        group = augroup,
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
        group = augroup,
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Auto-format ("lint") on save. Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if
        not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    -- Custom keybindings
    local opts = { buffer = args.data.buf, remap = false }
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
    vim.keymap.set({ "n", "v" }, "<leader><leader>", function()
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
  end,
})

function InlayToggle()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.pack helper commands
vim.api.nvim_create_user_command("PackList", function()
  vim.pack.update(nil, { offline = true })
end, {
  desc = "List installed packs",
})
vim.api.nvim_create_user_command("PackReset", function()
  vim.pack.update(nil, { target = "lockfile", offline = true })
end, {
  desc = "Reset installed packs",
})
