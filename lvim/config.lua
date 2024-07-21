--lvim settings

lvim.transparent_window = true

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-a>"] = "ggVG"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- require("nvim-treesitter.configs").setup({
--   -- Add languages to be installed here that you want installed for treesitter
--   ensure_installed = {
--     "go",
--     "lua",
--     "python",
--     "rust",
--     "typescript",
--     "regex",
--     "bash",
--     "markdown",
--     "markdown_inline",
--     "kdl",
--     "sql",
--   },

--   highlight = { enable = true },
--   indent = { enable = true },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = "<c-space>",
--       node_incremental = "<c-space>",
--       scope_incremental = "<c-s>",
--       node_decremental = "<c-backspace>",
--     },
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ["aa"] = "@parameter.outer",
--         ["ia"] = "@parameter.inner",
--         ["af"] = "@function.outer",
--         ["if"] = "@function.inner",
--         ["ac"] = "@class.outer",
--         ["ic"] = "@class.inner",
--         ["il"] = "@loop.inner",
--         ["al"] = "@loop.outer",
--       },
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         ["]m"] = "@function.outer",
--         ["]]"] = "@class.outer",
--       },
--       goto_next_end = {
--         ["]M"] = "@function.outer",
--         ["]["] = "@class.outer",
--       },
--       goto_previous_start = {
--         ["[m"] = "@function.outer",
--         ["[["] = "@class.outer",
--       },
--       goto_previous_end = {
--         ["[M"] = "@function.outer",
--         ["[]"] = "@class.outer",
--       },
--     },
--     swap = {
--       enable = true,
--       swap_next = {
--         ["<leader>a"] = "@parameter.inner",
--       },
--       swap_previous = {
--         ["<leader>A"] = "@parameter.inner",
--       },
--     },
--   },
-- })
----------------------
-- Treesitter
------------------------
lvim.builtin.treesitter.ensure_installed = {
	"go",
	"gomod",
}
local alpha = function()
	return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.7
------------------------
-- Plugins
------------------------
lvim.colorscheme = "cyberdream"
lvim.plugins = {
	"olexsmir/gopher.nvim",
	"leoluz/nvim-dap-go",
	"github/copilot.vim",
  {
    'p5quared/apple-music.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
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
				-- Recommended - see "Configuring" below for more config options
				transparent = true,
				italic_comments = true,
				hide_fillchars = true,
				borderless_telescope = true,
				terminal_colors = true,
				-- theme = {
				--   colors = {
				--     bg = "#16181a"
				--   }
				-- }
			})
			vim.cmd("colorscheme cyberdream") -- set the colorscheme
		end,
	},
  { "ThePrimeagen/harpoon" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
  },
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
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
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
}

------------------------
-- Formatting
------------------------
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "goimports", filetypes = { "go" } },
	{ command = "gofumpt", filetypes = { "go" } },
})

-- github coppilot settings
vim.g.copilot_no_tab_map = true
-- vim.keymap.set("i", "<C-a>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })
-- vim.cmd("inoremap <C-a> <Esc>:copilot#Accept('\\<CR>')<CR>")
-- lvim.keys.insert_mode["<C-a>"]                      = ":copilot#Accept('\\<CR>')<CR>"
vim.cmd([[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]])
-- vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
-- vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
vim.cmd([[highlight CopilotSuggestion guifg=#555555 ctermfg=8]])
------------------------
-- Dap
------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
	return
end

dapgo.setup()

------------------------
-- LSP
------------------------
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("golangci_lint_ls", {
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
	on_attach = function(client, bufnr)
		require("lvim.lsp").common_on_attach(client, bufnr)
		local _, _ = pcall(vim.lsp.codelens.refresh)
		local map = function(mode, lhs, rhs, desc)
			if desc then
				desc = desc
			end

			vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
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

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
	return
end

gopher.setup({
	commands = {
		go = "go",
		gomodifytags = "gomodifytags",
		gotests = "gotests",
		impl = "impl",
		iferr = "iferr",
	},
})
---------------PYTHON---------------
-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
	"python",
}

-- setup formatting
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({ { name = "black" } })
-- lvim.format_on_save.enabled = true
lvim.format_on_save = true
-- lvim.format_on_save.pattern = { "*.py", "*.tex" }

-- setup linting
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { command = "flake8", filetypes = { "python" } } })

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
	require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
	adapters = {
		require("neotest-python")({
			-- Extra arguments for nvim-dap configuration
			-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
			dap = {
				justMyCode = false,
				console = "integratedTerminal",
			},
			args = { "--log-level", "DEBUG", "--quiet" },
			runner = "pytest",
		}),
	},
})

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] =
	{ "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
	"Test Class",
}
lvim.builtin.which_key.mappings["dF"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
	"Test Class DAP",
}
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
	name = "Python",
	c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
lvim.transparent_window = true
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- table.insert(lvim.plugins, {
-- 	"zbirenbaum/copilot-cmp",
-- 	event = "InsertEnter",
-- 	dependencies = { "zbirenbaum/copilot.lua" },
-- 	config = function()
-- 		vim.defer_fn(function()
-- 			require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
-- 			require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
-- 		end, 100)
-- 	end,
-- })

lvim.builtin.lualine.options.theme = "tokyonight"
