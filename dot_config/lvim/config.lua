--------------------------------------------------------------------------------
--                           Commented-out Settings                           --
--  (Kept for future reference; these settings are NOT currently in use)       --
--------------------------------------------------------------------------------
-- vim.opt.wrap = true               -- wrap lines
-- vim.opt.relativenumber = true     -- relative line numbers

-- table.insert(lvim.plugins, {
--   "zbirenbaum/copilot-cmp",
--   event = "InsertEnter",
--   dependencies = { "zbirenbaum/copilot.lua" },
--   config = function()
--     vim.defer_fn(function()
--       require("copilot").setup()      -- https://github.com/zbirenbaum/copilot.lua
--       require("copilot_cmp").setup()  -- https://github.com/zbirenbaum/copilot-cmp
--     end, 100)
--   end,
-- })

-- {
--   'mvllow/modes.nvim',
--   tag = 'v0.2.0',
--   config = function()
--     require('modes').setup()
--   end
-- }

-- vim.keymap.set("i", "<C-a>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })
-- vim.cmd("inoremap <C-a> <Esc>:copilot#Accept('\\<CR>')<CR>")
-- lvim.keys.insert_mode["<C-a>"] = ":copilot#Accept('\\<CR>')<CR>"
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--                                 LVIM Settings                              --
--------------------------------------------------------------------------------
lvim.transparent_window               = true
lvim.builtin.nvimtree.setup.view.side = "right" -- or "left"
lvim.colorscheme                      = "cyberdream"
lvim.format_on_save                   = true
lvim.builtin.dap.active               = true
lvim.builtin.lualine.options.theme    = "cyberdream"
-- lvim.builtin.lualine.style            = "evilline"

--------------------------------------------------------------------------------
--                           Transparency & Neovide                           --
--------------------------------------------------------------------------------
local alpha                           = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end

-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency            = 0.7

--------------------------------------------------------------------------------
--                                 Key Mappings                               --
--------------------------------------------------------------------------------
lvim.keys.normal_mode["<C-s>"]        = ":w<cr>"
lvim.keys.insert_mode["<C-s>"]        = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-a>"]        = "ggVG"
lvim.keys.normal_mode["<S-l>"]        = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"]        = ":BufferLineCyclePrev<CR>"

--------------------------------------------------------------------------------
--                      LSP Manager & LSP Server Configuration                --
--------------------------------------------------------------------------------
local lsp_manager                     = require("lvim.lsp.manager")

-- Lua LS
lsp_manager.setup("lua_ls", {
  on_attach = require("lvim.lsp").common_on_attach,
  capabilities = require("lvim.lsp").common_capabilities(),
})

-- TS Server
lsp_manager.setup("tsserver", {
  on_attach = require("lvim.lsp").common_on_attach,
  capabilities = require("lvim.lsp").common_capabilities(),
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
})

-- Skip "gopls" from automatic configuration
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

-- Go lint LSP
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

-- Gopls
lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    pcall(vim.lsp.codelens.refresh)

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        silent = true,
        desc = desc,
        buffer = bufnr,
        noremap = true,
      })
    end

    map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
    map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
    map("n", "<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
    map("n", "<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
    map("n", "<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
    map("n", "<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
    map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
    map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
    map("n", "<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = false,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
})

--------------------------------------------------------------------------------
--                                 Treesitter                                 --
--------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    "go",
    "lua",
    "python",
    "rust",
    "typescript",
    "regex",
    "bash",
    "markdown",
    "markdown_inline",
    "kdl",
    "sql",
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "<c-space>",
      node_incremental  = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental  = "<c-backspace>",
    },
  },
  textobjects = {
    select = {
      enable    = true,
      lookahead = true, -- Automatically jump forward to textobj
      keymaps   = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
      },
    },
    move = {
      enable              = true,
      set_jumps           = true,
      goto_next_start     = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end       = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end   = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable        = true,
      swap_next     = { ["<leader>a"] = "@parameter.inner" },
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
    },
  },
})
-- Additional built-in Treesitter configuration
lvim.builtin.treesitter.ensure_installed = {
  "go",
  "gomod",
}
--------------------------------------------------------------------------------
--                             Plugin Configuration                           --
--------------------------------------------------------------------------------
lvim.plugins = {
  "sphamba/smear-cursor.nvim",
  { "ellisonleao/gruvbox.nvim",  priority = 1000, config = true, opts = ... },
  -- {
  --   "rachartier/tiny-glimmer.nvim",
  --   event = "TextYankPost",
  -- },
  {
    "ghostty",
    dir = "/Applications/Ghostty.app/Contents/Resources/vim/vimfiles/",
    lazy = false,
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
  },
  { "rasulomaroff/reactive.nvim" },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        -- mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        -- hide_cursor = true,
        -- stop_eof = true,
        -- respect_scrolloff = false,
        -- cursor_scrolls_alone = true,
        -- easing = 'linear',
        -- pre_hook = nil,
        -- post_hook = nil,
        -- performance_mode = false,
        -- ignored_events = { 'WinScrolled', 'CursorMoved' },
      })
    end,
  },
  "olexsmir/gopher.nvim",
  "leoluz/nvim-dap-go",
  "github/copilot.vim",
  {
    "p5quared/apple-music.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = true,
    keys = {
      { "<leader>amp", function() require("apple-music").toggle_play() end,               desc = "Toggle [P]layback" },
      { "<leader>ams", function() require("apple-music").toggle_shuffle() end,            desc = "Toggle [S]huffle" },
      { "<leader>fp",  function() require("apple-music").select_playlist_telescope() end, desc = "[F]ind [P]laylists" },
      { "<leader>fa",  function() require("apple-music").select_album_telescope() end,    desc = "[F]ind [A]lbum" },
      { "<leader>fs",  function() require("apple-music").select_track_telescope() end,    desc = "[F]ind [S]ong" },
      { "<leader>amx", function() require("apple-music").cleanup_all() end,               desc = "Cleanup Temp Playlists" },
    },
  },
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python",
  "lervag/vimtex",
  "nvim-neotest/nvim-nio",
  "meznaric/key-analyzer.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent        = true,
        italic_comments    = true,
        hide_fillchars     = true,
        borderless_pickers = true,
        terminal_colors    = true,
        -- theme = {
        --   colors = { bg = "#16181a" }
        -- }
      })
      vim.cmd("colorscheme cyberdream")
    end,
  },
  { "ThePrimeagen/harpoon" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { "p00f/nvim-ts-rainbow" },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup({
        -- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        -- hide_cursor = true,
        -- stop_eof = true,
        -- use_local_scrolloff = false,
        -- respect_scrolloff = false,
        -- cursor_scrolls_alone = true,
        -- easing_function = nil,
        -- pre_hook = nil,
        -- post_hook = nil,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  { "igorgue/danger" },
}
-- require('tiny-glimmer').setup({
--   enabled = true,
--   default_animation = "fade",
--   refresh_interval_ms = 6,

--   -- Only use if you have a transparent background
--   -- It will override the highlight group background color for `to_color` in all animations
--   transparency_color = nil,

--   animations = {
--     fade = {
--       max_duration = 250,
--       chars_for_max_duration = 10,
--     },
--     bounce = {
--       max_duration = 500,
--       chars_for_max_duration = 20,
--       oscillation_count = 1,
--     },
--     left_to_right = {
--       max_duration = 350,
--       chars_for_max_duration = 40,
--       lingering_time = 50,
--     },
--     pulse = {
--       max_duration = 400,
--       chars_for_max_duration = 15,
--       pulse_count = 2,
--       intensity = 1.2,
--     },
--     rainbow = {
--       max_duration = 600,
--       chars_for_max_duration = 20,
--     },
--     custom = {
--       max_duration = 350,
--       chars_for_max_duration = 40,
--       color = hl_visual_bg,

--       -- Custom effect function
--       -- @param self table The effect object
--       -- @param progress number The progress of the animation [0, 1]
--       --
--       -- Should return a color and a progress value
--       -- that represents how much of the animation should be drawn
--       effect = function(self, progress)
--         return self.settings.color, progress
--       end,
--     },
--   },
--   virt_text = {
--     priority = 2048,
--   },
-- })
-- Reactive plugin setup
require("reactive").setup({
  builtin = {
    cursorline = true,
    cursor     = true,
    modemsg    = true,
  },
})

--------------------------------------------------------------------------------
--                            WhichKey Mappings                               --
--------------------------------------------------------------------------------
-- Inc Rename
lvim.builtin.which_key.mappings["r"] = {
  name = "inc_rename",
  n = { ":IncRename ", "Rename symbol under cursor" },
  p = { "<cmd>FloatermNew --autoclose=0 python %<cr>", "Run python file in terminal" },
  P = { '<cmd>TermExec go_back=0 cmd="p %"<cr>', "Run python file in terminal" },
  c = { "<cmd>FloatermNew --autoclose=0 g++ % -o %< && ./%<<cr>", "Run C file in terminal" },
  C = { '<cmd>TermExec go_back=0 cmd="g++ % -o % && ./%"<cr>', "Run C file in terminal" },
  -- n = {
  --   function()
  --     return ":IncRename " .. vim.fn.expand("<cword>")
  --   end, { expr = true },
  --   "Rename symbol under cursor"
  -- },
}

-- Folding
lvim.builtin.which_key.mappings["f"] = {
  name = "Folding",
  c = { "<cmd>foldclose<cr>", "Close all folds" },
  o = { "<cmd>foldopen<cr>", "Open all folds" },
  t = { "<cmd>foldtext<cr>", "Toggle fold text" },
  r = { "<cmd>foldreset<cr>", "Reset folds" },
  R = { "<cmd>foldremove<cr>", "Remove folds" },
  z = { "<cmd>set foldlevel=20<cr>", "Set fold level" },
}

-- Harpoon
lvim.builtin.which_key.mappings["H"] = {
  name = "Harpoon marks",
  { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle quick menu" },
}
lvim.builtin.which_key.mappings["h"] = {
  name = "Harpoon",
  a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
  d = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle quick menu" },
  t = { "<cmd>Telescope harpoon marks<cr>", "Telescope view" },
  h = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Go to left file" },
  l = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Go to right file" },
}

-- Projects
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- Trouble
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- Python environment switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

--------------------------------------------------------------------------------
--                               Formatters                                   --
--------------------------------------------------------------------------------
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt",   filetypes = { "go" } },
  { name = "black" },
  { name = "biome" },
})

--------------------------------------------------------------------------------
--                      GitHub Copilot Keymap & Settings                      --
--------------------------------------------------------------------------------
vim.g.copilot_no_tab_map = true
vim.cmd([[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]])
vim.cmd([[highlight CopilotSuggestion guifg=#555555 ctermfg=8]])

--------------------------------------------------------------------------------
--                                   DAP                                      --
--------------------------------------------------------------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if dap_ok then
  dapgo.setup()
end

--------------------------------------------------------------------------------
--                               Go (Gopher)                                  --
--------------------------------------------------------------------------------
local status_ok, gopher = pcall(require, "gopher")
if status_ok then
  gopher.setup({
    commands = {
      go           = "go",
      gomodifytags = "gomodifytags",
      gotests      = "gotests",
      impl         = "impl",
      iferr        = "iferr",
    },
  })
end

--------------------------------------------------------------------------------
--                                Python                                      --
--------------------------------------------------------------------------------
-- Python syntax highlighting
lvim.builtin.treesitter.ensure_installed = { "python" }

-- Python linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "flake8", filetypes = { "python" } },
})

-- Setup Debug Adapter for Python
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- Neotest Python
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap    = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args   = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    }),
  },
})

-- Python Test Keymaps
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
  "Test Class DAP",
}
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

--------------------------------------------------------------------------------
--                     Mason: Ensure Tools & LSP Servers Installed            --
--------------------------------------------------------------------------------
lvim.builtin.mason.ensure_installed = {
  -- LSP Servers
  "autotools_ls",
  "bashls",
  "clangd",
  "cssls",
  "dockerls",
  "eslint",
  "gopls",
  "golangci_lint_ls",
  "helm_ls",
  "html",
  "jsonls",
  "lua_ls",
  "prismals",
  "pyright",
  "ruff_lsp",
  "rust_analyzer",
  "terraformls",
  "tsserver",
  "yamlls",

  -- Formatters
  "bibtex-tidy",
  "black",
  "biome",
  "gofumpt",
  "goimports",
  "latexindent",
  "prettier",
  "sqlfmt",
  "ruff",
  "rustfmt",
  "sqlfluff",

  -- Others
  "delve",   -- Debugger for Go
  "vale_ls", -- Linter
  "vimls",   -- Vimscript LSP
}

--------------------------------------------------------------------------------
--                              Key Analyzer                                  --
--------------------------------------------------------------------------------
require("key-analyzer").setup({
  command_name = "KeyAnalyzer",
  highlights = {
    bracket_used              = "KeyAnalyzerBracketUsed",
    letter_used               = "KeyAnalyzerLetterUsed",
    bracket_unused            = "KeyAnalyzerBracketUnused",
    letter_unused             = "KeyAnalyzerLetterUnused",
    promo_highlight           = "KeyAnalyzerPromo",
    define_default_highlights = true,
  },
})
-- on boot upgrade all packages from mason
