-- general
lvim.log.level                       = "warn"
lvim.transparent_window              = true
vim.g.material_style                 = "deep ocean"
lvim.colorscheme                     = "lunar"
lvim.builtin.lualine.style           = "bubbles"
lvim.leader                          = "space"
vim.opt.relativenumber               = true
lvim.format_on_save                  = true
vim.g.vimtex_view_method             = 'zathura'
vim.g.vimtex_quickfix_mode           = 0

-- folding unfolding
vim.opt.foldlevel                    = 20
vim.opt.foldmethod                   = "expr"
vim.opt.foldexpr                     = "nvim_treesitter#foldexpr()"
-- lvim.keys.insert_mode["<leader>fc"]  = "<cmd>foldclose<cr>"
lvim.keys.normal_mode["<leader>fc"]  = "<cmd>foldclose<cr>"
-- vim.keymap.set("n", "<leader>rn", function()
--   return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true })
-- local vim                                           = vim
-- local api                                           = vim.api
-- local M                                             = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
-- function M.nvim_create_augroups(definitions)
--   for group_name, definition in pairs(definitions) do
--     api.nvim_command('augroup ' .. group_name)
--     api.nvim_command('autocmd!')
--     for _, def in ipairs(definition) do
--       local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
--       api.nvim_command(command)
--     end
--     api.nvim_command('augroup END')
--   end
-- end
-- split windows
-- lvim.keys.normal_mode["<leader>vs"]                 = "<cmd>vsp<cr>"
lvim.builtin.which_key.mappings["v"] = {
  name = "Window Split",
  s = { "<cmd>vsp<cr>", "Split window vertically" },
}
lvim.builtin.which_key.mappings["r"] = {
  name = "inc_rename",
  n = { ":IncRename ", "Rename symbol under cursor" },
  p = { "<cmd>FloatermNew --autoclose=0 python %<cr>", "Run python file in terminal" },
  P = { '<cmd>TermExec go_back=0 cmd="p %"<cr>', "Run python file in terminal" },
  c = { "<cmd>FloatermNew --autoclose=0 g++ % -o %< && ./%<<cr>", "Run C file in terminal" },
  C = { '<cmd>TermExec go_back=0 cmd="g++ % -o % && ./%"<cr>', "Run C file in terminal" },
  -- n = {
  --
  --   function()
  --     return ":IncRename " .. vim.fn.expand("<cword>")
  --   end, { expr = true },
  --   "Rename symbol under cursor" },
}
lvim.builtin.which_key.mappings["z"] = {
  name = "zathura",
  t = { ":!zathura <C-r>=expand('%:r')<cr>.pdf &<cr>", "Close all folds" },
}
-- lvim.builtin.which_key.mappings["f"] = {
--   name = "Folding",
--   c = { "<cmd>foldclose<cr>", "Close all folds" },
--   o = { "<cmd>foldopen<cr>", "Open all folds" },
--   t = { "<cmd>foldtext<cr>", "Toggle fold text" },
--   r = { "<cmd>foldreset<cr>", "Reset folds" },
--   R = { "<cmd>foldremove<cr>", "Remove folds" },
--   z = { "<cmd>set foldlevel=20<cr>", "Set fold level" },
-- }
lvim.builtin.which_key.mappings["H"] = {
  name = "Harpoon marks",
  { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle quick menu" },
}
lvim.builtin.which_key.mappings["h"] = {
  name = "Harpoon",
  a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
  d = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle quick menu" },
  t = { "<cmd>Telescope harpoon marks<cr>", "Telescope view" },
  l = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Go to left file" },
  r = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Go to right file" },
}


-- local autoCommands = {
--     -- other autocommands
--     open_folds = {
--         { "BufReadPost,FileReadPost", "*", "normal zR" }
--     }
-- }
-- github coppilot settings
vim.g.copilot_no_tab_map = true
-- vim.keymap.set("i", "<C-a>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })
-- vim.cmd("inoremap <C-a> <Esc>:copilot#Accept('\\<CR>')<CR>")
-- lvim.keys.insert_mode["<C-a>"]                      = ":copilot#Accept('\\<CR>')<CR>"
vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
-- vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
-- vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]


-- M.nvim_create_augroups(autoCommands)

-- vim.opt.foldcolumn                                                 = "1"
-- vim.opt.foldlevel                                                  = 99
-- vim.opt.foldlevelstart                                             = -1
-- vim.opt.foldenable                                                 = true
-- local capabilities                                                 = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.foldingRange                             = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true,
-- }
-- M.capabilities                                                     = require("cmp_nvim_lsp").default_capabilities(
--         capabilities) -- for nvim-cmp

-- local opts                                                         = {
--     on_attach = M.on_attach,
--     capabilities = M.capabilities,
--     flags = {
--         debounce_text_changes = 150,
--     },
-- }
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"]                      = ":w<cr>"
lvim.keys.insert_mode["<C-s>"]                      = "<cmd>w<cr>"
lvim.keys.normal_mode["<C-a>"]                      = "ggVG"
lvim.keys.normal_mode["<S-l>"]                      = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"]                      = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"]                = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"]                = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active                           = true
lvim.builtin.alpha.mode                             = "dashboard"
lvim.builtin.terminal.active                        = true
lvim.builtin.nvimtree.setup.view.side               = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed            = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "cpp",
  "fish",
}

lvim.builtin.treesitter.ignore_install              = { "haskell" }
lvim.builtin.treesitter.highlight.enable            = true
-- github copilot
vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--   "sumneko_lua",
--   "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!dependencies `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!dependencies `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- Additional Plugins
lvim.plugins = {
  { "ThePrimeagen/harpoon" },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "marko-cerovac/material.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      }
    },
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
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
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
  },
  {
    "kyazdani42/nvim-tree.lua",
    enable = lvim.builtin.nvimtree.active,
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
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
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  -- {
  --     "Pocco81/auto-save.nvim",
  --     opt = true,
  --     config = function()
  --       require("auto-save").setup()
  --     end,
  -- },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  { "echasnovski/mini.nvim" },
  -- { "nvim-lualine/lualine.nvim" },
  -- { "kevinhwang91/nvim-ufo",
  --     opt = true,
  --     event = { "BufReadPre" },
  --     wants = { "promise-async" },
  --     dependencies = "kevinhwang91/promise-async",
  --     config = function()
  --       require("ufo").setup {
  --           provider_selector = function(bufnr, filetype)
  --             return { "lsp", "treesitter", "indent" }
  --           end,
  --       }
  --       vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  --       vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  --     end,
  -- },
  { "ThePrimeagen/vim-be-good" },
  { "github/copilot.vim" },
  { "lervag/vimtex" },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      lsp = {
        signature = {
          enabled = false,
        },
      },
      presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = false,           -- use a classic bottom cmdline for search
        command_palette = false,         -- position the cmdline and popupmenu together
        long_message_to_split = false,   -- long messages will be sent to a split
        inc_rename = false,              -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,          -- add a border to hover docs and signature help
        cmdline_output_to_split = false, -- send the output of a command you executed in the cmdline to a split
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  -- lazy.nvim
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   require("noice").setup({
  --     lsp = {
  --       signature = {
  --         enabled = false,
  --       },
  --       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true,
  --       },
  --     },
  --     -- you can enable a preset for easier configuration
  --     presets = {
  --       bottom_search = true,         -- use a classic bottom cmdline for search
  --       command_palette = true,       -- position the cmdline and popupmenu together
  --       long_message_to_split = true, -- long messages will be sent to a split
  --       inc_rename = false,           -- enables an input dialog for inc-rename.nvim
  --       lsp_doc_border = false,       -- add a border to hover docs and signature help
  --     },
  --   }),
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   }
  -- },

  -- {
  --   "rcarriga/nvim-notify",
  --   require("notify").setup({
  --     background_colour = "#000000",
  --   })

  -- },
  -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "nvim-telescope/telescope-media-files.nvim" },
  { "nvim-telescope/telescope-frecency.nvim" },
  { "nvim-telescope/telescope-dap.nvim" },
  { "nvim-telescope/telescope-packer.nvim" },
  { "nvim-telescope/telescope-symbols.nvim" },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "echasnovski/mini.indentscope",
    config = function()
      require("mini.indentscope").setup({
        draw = {
          -- draw the indent guides
          indent = true,
          -- draw the indent scope
          scope = true,
          -- draw the indent scope border
          border = true,
        },
        symbol = '│',
      })
    end,
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120,              -- Width of the floating window
        height = 25,              -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false,            -- Print debug information
        opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil      -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },
  -- { "nvim-lua/plenary" },
  { "igorgue/danger" },
  -- { "askfiy/visual_studio_code",
  --   config = function()
  --     require("visual_studio_code").setup({
  --       mode = "dark",
  --       transparenct = true,
  --       expands = {
  --         hop = true,
  --         lazy = true,
  --         aerial = true,
  --         fidget = true,
  --         null_ls = true,
  --         nvim_cmp = true,
  --         gitsigns = true,
  --         which_key = true,
  --         nvim_tree = true,
  --         lspconfig = true,
  --         telescope = true,
  --         bufferline = true,
  --         nvim_navic = true,
  --         nvim_notify = true,
  --         vim_illuminate = true,
  --         nvim_treesitter = true,
  --         nvim_ts_rainbow = true,
  --         nvim_scrollview = true,
  --         indent_blankline = true,
  --         vim_visual_multi = true,
  --       },
  --       hooks = {
  --         before = function(conf, colors, utils)
  --         end,
  --         after = function(conf, colors, utils)
  --         end,
  --       },
  --     })
  --   end,
  --   opt = false, }
  { "voldikss/vim-floaterm" },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     lsp = {
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --       },
  --     },
  --     presets = {
  --       bottom_search = true,
  --       command_palette = true,
  --       long_message_to_split = true,
  --     },
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                 desc = "Redirect Cmdline" },
  --     { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
  --     { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
  --     { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
  --     { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,              expr = true,              desc = "Scroll forward",  mode = { "i", "n", "s" } },
  --     { "<c-b>",       function() if not require("noice.lsp").scroll( -4) then return "<c-b>" end end, silent = true,             expr = true,              desc = "Scroll backward", mode = { "i", "n", "s" } },
  --   },
  -- },
}
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
lvim.builtin.treesitter.rainbow.enable = true
require("telescope").load_extension('harpoon')
require("notify").setup({
  background_colour = "#000000",
})


-------------------------c++-------------------------

lvim.builtin.treesitter.highlight.enable = true

-- -- set virtual_text for diagnostics eol

-- lvim.diagnostic.config({ virtual_text = true })
-- -- lvim.diagnostic.config.virtual_text = true
-- -- auto install treesitter parsers
-- lvim.builtin.treesitter.ensure_installed = { "cpp", "c" }

-- -- Additional Plugins
-- table.insert(lvim.plugins, {
--   "p00f/clangd_extensions.nvim",
-- })

local cmp_nvim_lsp = require "cmp_nvim_lsp"

require("lspconfig").clangd.setup {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(),
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

-- -- some settings can only passed as commandline flags, see `clangd --help`
-- local clangd_flags = {
--   "--offset-encoding=utf-16", --temporary fix for null-ls
--   "--background-index",
--   "--fallback-style=Google",
--   "--all-scopes-completion",
--   "--clang-tidy",
--   "--log=error",
--   "--suggest-missing-includes",
--   "--cross-file-rename",
--   "--completion-style=detailed",
--   "--pch-storage=memory", -- could also be disk
--   "--folding-ranges",
--   "--enable-config",      -- clangd 11+ supports reading from .clangd configuration file
--   "--limit-references=1000",
--   "--limit-resutls=1000",
--   "--malloc-trim",
--   "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
--   "--header-insertion=never",
--   "--query-driver=<list-of-white-listed-complers>"
-- }

-- local provider = "clangd"

-- local custom_on_attach = function(client, bufnr)
--   require("lvim.lsp").common_on_attach(client, bufnr)
--   -- local opts = { noremap = true, silent = true, buffer = bufnr }
--   -- vim.keymap.set("n", "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
--   -- vim.keymap.set("x", "<leader>lA", "<cmd>ClangdAST<cr>", opts)
--   -- vim.keymap.set("n", "<leader>lH", "<cmd>ClangdTypeHierarchy<cr>", opts)
--   -- vim.keymap.set("n", "<leader>lt", "<cmd>ClangdSymbolInfo<cr>", opts)
--   -- vim.keymap.set("n", "<leader>lm", "<cmd>ClangdMemoryUsage<cr>", opts)

--   require("clangd_extensions.inlay_hints").setup_autocmd()
--   require("clangd_extensions.inlay_hints").set_inlay_hints()
-- end

-- -- local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
-- -- if status_ok then
-- --   clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
-- -- end

-- local custom_on_init = function(client, bufnr)
--   require("lvim.lsp").common_on_init(client, bufnr)
--   require("clangd_extensions").setup {}
--   require("clangd_extensions.ast").init()
--   vim.cmd [[
--   command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
--   command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
--   command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
--   command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
--   command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
--   ]]
-- end

-- local opts = {
--   cmd = { provider, unpack(clangd_flags) },
--   -- cmd = {
--   --   "clangd",
--   --   "--offset-encoding=utf-16",
--   -- },
--   on_attach = custom_on_attach,
--   on_init = custom_on_init,
-- }
-- require("lvim.lsp.manager").setup("clangd", opts)

-- -- require("null-ls").diable {
-- --   filetypes = { "c", "cpp" },
-- -- }
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { "utf-16" }
-- require("lspconfig").clangd.setup({ capabilities = capabilities })

-- -- install codelldb with :MasonInstall codelldb
-- -- configure nvim-dap (codelldb)
-- lvim.builtin.dap.on_config_done = function(dap)
--   dap.adapters.codelldb = {
--     type = "server",
--     port = "${port}",
--     executable = {
--       -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
--       command = "codelldb",
--       args = { "--port", "${port}" },

--       -- On windows you may have to uncomment this:
--       -- detached = false,
--     },
--   }

--   dap.configurations.cpp = {
--     {
--       name = "Launch file",
--       type = "codelldb",
--       request = "launch",
--       program = function()
--         local path
--         vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
--           path = input
--         end)
--         vim.cmd [[redraw]]
--         return path
--       end,
--       cwd = "${workspaceFolder}",
--       stopOnEntry = false,
--     },
--   }

--   dap.configurations.c = dap.configurations.cpp
-- end
-- -----------------------python-----------------------
-- table.insert(lvim.plugins, {
--   "ChristianChiarulli/swenv.nvim",
--   "stevearc/dressing.nvim",
--   "mfussenegger/nvim-dap-python",
--   "nvim-neotest/neotest",
--   "nvim-neotest/neotest-python",
-- })
-- -- automatically install python syntax highlighting
-- lvim.builtin.treesitter.ensure_installed = {
--   "python",
-- }

-- -- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }
-- -- setup formatting
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup { { name = "black" }, }


-- -- setup debug adapter
-- lvim.builtin.dap.active = true
-- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
-- pcall(function()
--   require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
-- end)

-- -- setup testing
-- require("neotest").setup({
--   adapters = {
--     require("neotest-python")({
--       -- Extra arguments for nvim-dap configuration
--       -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
--       dap = {
--         justMyCode = false,
--         console = "integratedTerminal",
--       },
--       args = { "--log-level", "DEBUG", "--quiet" },
--       runner = "pytest",
--     })
--   }
-- })

-- lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
--   "Test Method" }
-- lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
--   "Test Method DAP" }
-- lvim.builtin.which_key.mappings["df"] = {
--   "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
-- lvim.builtin.which_key.mappings["dF"] = {
--   "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
-- lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }


-- -- binding for switching
-- lvim.builtin.which_key.mappings["C"] = {
--   name = "Python",
--   c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
-- }
