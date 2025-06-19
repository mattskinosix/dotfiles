-- Install packer
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

require("lazy").setup({
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/EBW/docs",
        },
        {
          name = "personal it docs",
          path = "~/IT_DOC",
        },
      },

      -- see below for full list of options 👇
    },
  },
  {
    "LunarVim/bigfile.nvim",
  },
  {
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    module = false,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      })

    end,
  },
  {'mg979/vim-visual-multi' },  
  { 'uga-rosa/translate.nvim' },
  { 'knubie/vim-kitty-navigator' },
  { 'mfussenegger/nvim-dap' },
  { 'Pocco81/dap-buddy.nvim' },
  { 'renerocksai/calendar-vim' },
  {
    'renerocksai/telekasten.nvim',
    dependencies = {'nvim-telescope/telescope.nvim'}
  },
  {
    'kyazdani42/nvim-tree.lua',
  },
  -- install without yarn or npm
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    "rest-nvim/rest.nvim",
    event = "VeryLazy",
    ft = { "http" },
    dependencies = {
      {
        "luarocks.nvim",
      },
    },
    config = function()
      require("rest-nvim").setup()
      require("telescope").load_extension("rest")
    end,
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run rest http request under cursor" },
      { "<leader>re", "<cmd>Telescope rest select_env<cr>", desc = "Select environment file for rest testing" },
    },
  },
  { "ellisonleao/gruvbox.nvim" },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },
  'rbong/vim-flog',
  { 'tpope/vim-surround' },
  'tpope/vim-fugitive', -- Git commands in nvim
  'tpope/vim-commentary', -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "nvim-telescope/telescope.nvim", tag = '0.1.2' },
  { "nvim-telescope/telescope-file-browser.nvim" },
  'voldikss/vim-browser-search',
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  { "nvim-telescope/telescope-media-files.nvim" },
  -- Add indentation guides even on blank lines
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  ({"petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim"}),
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "octaltree/cmp-look",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-cmdline",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end
  },
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  'windwp/nvim-autopairs',
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',
  -- using packer.nvim
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'kyazdani42/nvim-web-devicons'},
  'prettier/vim-prettier',
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
  },
  -- Lua
  { "RRethy/vim-illuminate" },
  { "windwp/windline.nvim" },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          project = {
            enable = false,
            -- rest of project config
          },
          header = {   
            ' ▓███████████████▓   ▒▓██████▓▒ ▒▓████████▓▒▒▓████████▓▒ ▒▓███████▓▒ ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒ ▒▓███████▓▒  ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▓███████████████▓   ', 
            '▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒   ▒▓█▓▒       ▒▓█▓▒    ▒▓█▓▒░       ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒  ', 
            '▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒   ▒▓█▓▒       ▒▓█▓▒    ▒▓█▓▒░       ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒  ', 
            '▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒ ▒▓████████▓▒   ▒▓█▓▒       ▒▓█▓▒     ▒▓██████▓▒  ▒▓███████▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒  ', 
            '▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒   ▒▓█▓▒       ▒▓█▓▒           ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒   ▒▓█▓▓█▓▒   ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒  ', 
            '▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒   ▒▓█▓▒       ▒▓█▓▒           ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒   ▒▓█▓▓█▓▒   ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒  ', 
            '▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒   ▒▓█▓▒       ▒▓█▓▒    ▒▓███████▓▒  ▒▓█▓▒  ▒▓█▓▒ ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒    ▒▓██▓▒    ▒▓█▓▒ ▒▓█▓▒  ▒▓█▓▒  ▒▓█▓▒  ', 
          },
          shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Telescope app',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope dotfiles',
              key = 'd',
            },
          },
        },
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  {'akinsho/toggleterm.nvim', version = "*", config = true}
})


vim.notify = require "notify"

require("trouble").setup {
  position = "bottom", -- position of the list can be: bottom, top, left, right
  height = 10, -- height of the trouble list when position is top or bottom
  width = 50, -- width of the list when position is left or right
  icons = true, -- use devicons for filenames
  mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = "", -- icon used for open folds
  fold_closed = "", -- icon used for closed folds
  group = true, -- group results by file
  padding = true, -- add an extra new line on top of the list
  action_keys = { -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {},
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh
    jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
    open_split = { "<c-x>" }, -- open buffer in new split
    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
    open_tab = { "<c-t>" }, -- open buffer in new tab
    jump_close = {"o"}, -- jump to the diagnostic and close the listA
    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P", -- toggle auto_preview
    hover = "K", -- opens a small popup with the full multiline message
    preview = "p", -- preview the diagnostic location
    close_folds = {"zM", "zm"}, -- close all folds
    open_folds = {"zR", "zr"}, -- open all folds
    toggle_fold = {"zA", "za"}, -- toggle fold of current file
    previous = "k", -- previous item
    next = "j" -- next item
  },
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = false, -- automatically close the list when you have no diagnostics
  auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false, -- automatically fold a file trouble list at creation
  auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
  signs = {
    -- icons / text used for a diagnostic
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
  },
  use_diagnostic_signs = false

}

-- ####################################################################################################################################################################################
--                                                                       traslate 
-- ####################################################################################################################################################################################
require("translate").setup({
  default = {
    command = "google",
  },
  preset = {
    output = {
      replace = "rate",
    },
  },
})

-- ####################################################################################################################################################################################
--                                                                        WILDLINE
-- ####################################################################################################################################################################################
local windline = require('windline')
require('wlsample.airline_luffy')
--- you need to define your status lines here

-- ####################################################################################################################################################################################
--                                                                        VIMSPECTOR
-- ####################################################################################################################################################################################
require('telekasten').setup({
  home = vim.fn.expand("~/zettelkasten"), -- Put the name of your notes directory here
})

local dap = require('dap')

dap.adapters.python = {
  type = 'executable';
  command = 'python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${workspaceFolder}/${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return 'python'
      end
    end;
  },
}

-- ####################################################################################################################################################################################
--                                                                        BLANKLINE
-- ####################################################################################################################################################################################

-- ####################################################################################################################################################################################
--                                                                          DBUI
-- ####################################################################################################################################################################################
vim.g.dev= 'postgres://postgres:password@localhost:10000/postgres'
vim.cmd [[ autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} }) ]]


-- ####################################################################################################################################################################################
--                                                                          TELESCOPE
-- ####################################################################################################################################################################################

vim.g.dashboard_default_executive = 'telescope'

-- ####################################################################################################################################################################################
--                                                                           LSP
-- ####################################################################################################################################################################################



-- ####################################################################################################################################################################################
--                                                                           nerdtree
-- ####################################################################################################################################################################################

vim.g.mkdp_echo_preview_url = 1;
vim.g.mkdp_auto_start = 1;
local OpenMarkdownPreview = function(url)
  print(url)
  vim.cmd [["silent ! firefox --new-window " . a:url]]
end
vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

-- ####################################################################################################################################################################################
--                                                                           CMP
-- ####################################################################################################################################################################################
--
local cmp = require 'cmp'
-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete({ behavior = cmp.ConfirmBehavior.Replace, select = true })
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),

  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'snippy' },
    { name = 'omni' },
    { name = 'orgmode' },

  },{{ name = 'path' }}-- For ultisnips users.
  )
}

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- ####################################################################################################################################################################################
--                                                                          NPAIRS
-- ####################################################################################################################################################################################

local npairs = require('nvim-autopairs')

npairs.setup({
  check_ts = true,
})


-- ####################################################################################################################################################################################
--                                                                           VARIUS SETTING
-- ####################################################################################################################################################################################

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.term=kitty

vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme gruvbox]]
-- ####################################################################################################################################################################################
--                                                                           STATUSBAR
-- ####################################################################################################################################################################################


-- ####################################################################################################################################################################################
--                                                                           LEADER
-- ####################################################################################################################################################################################


--Remap space as leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.netrw_banner=1
vim.g.netrw_liststyle=3
vim.g.netrw_altv=1
vim.g.netrw_winsize=25
vim.g.netrw_browse_split = 4
vim.g.netrw_localcopydircmd='cp -r'

-- ####################################################################################################################################################################################
--                                                                           LSP
-- ####################################################################################################################################################################################

-- Gitsigns
require('gitsigns').setup {
}
-- ####################################################################################################################################################################################
--                                                                           TELESCOPE
-- ####################################################################################################################################################################################

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension('file_browser')
require('telescope').load_extension('media_files')

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
  },
  pickers = {
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
    },
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  }
}

-- ####################################################################################################################################################################################
--                                                                           TREESITTER
-- ####################################################################################################################################################################################


require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = function(lang, bufnr) -- Disable in large C++ buffers
      return vim.api.nvim_buf_line_count(bufnr) > 5000
    end,
  },
  indent = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in large C++ buffers
      return vim.api.nvim_buf_line_count(bufnr) > 5000
    end,
  },
  incremental_selection = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in large C++ buffers
      return vim.api.nvim_buf_line_count(bufnr) > 5000
    end,

    autotag = {
      enable = true,
    },
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
}

-- ####################################################################################################################################################################################
--                                                                           MAPPING
-- ####################################################################################################################################################################################

--Add leader shortcuts
vim.api.nvim_set_keymap('v', '<C-c>', [["+y]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', [["+p]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<leader>pt', [[<cmd>BufferLineTogglePin<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>1', [[<cmd>ToggleTerm 1<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', [[<cmd>ToggleTerm 2<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', [[<cmd>ToggleTerm 3<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', [[<cmd>ToggleTerm 4<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>5', [[<cmd>ToggleTerm 5<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>6', [[<cmd>ToggleTerm 6<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>7', [[<cmd>ToggleTerm 7<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>8', [[<cmd>ToggleTerm 8<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>9', [[<cmd>ToggleTerm 9<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', [[<cmd>MCstart<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', [[<cmd>Rest run<cr>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', [[:NvimTreeOpen<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>Git<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', [[<cmd>w<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fbg', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ws', [[<cmd>lua require("telescope").extensions.arecibo.websearch()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>Telescope file_browser<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cs', [[<Plug>(GitLabToggleCodeSuggestions)]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ci', [[<Plug>BujoAddnormal]], { noremap = false, silent = true })

vim.api.nvim_set_keymap('n', '<leader>cc', [[<Plug>BujoChecknormal]], { noremap = false, silent = true })

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>qf", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

vim.api.nvim_set_keymap('n', '<leader>tn', [[<cmd>TestNearest <cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', [[<cmd>TestFile <cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ts', [[<cmd>TestSuite <cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tl', [[<cmd>TestLast <cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tv', [[<cmd>TestVisit <cr>]], { noremap = true, silent = true })
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-LeftMouse>', '<Plug>(VM-Mouse-Column)', opts)
vim.api.nvim_set_keymap('n', '<C-RightMouse>', '<Plug>(VM-Mouse-Cursor)', opts)


-- ####################################################################################################################################################################################
--                                                                           LSP
-- ####################################################################################################################################################################################
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  {"🭽", "FloatBorder"},
  {"▔", "FloatBorder"},
  {"🭾", "FloatBorder"},
  {"▕", "FloatBorder"},
  {"🭿", "FloatBorder"},
  {"▁", "FloatBorder"},
  {"🭼", "FloatBorder"},
  {"▏", "FloatBorder"},
}

-- LSP settings (for overriding per client)
local handlers =  { ["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }), }

vim.diagnostic.config({
  virtual_text = false,
})
local lspconfig = require('lspconfig') 
local servers = {
  'rust_analyzer',
  'dockerls', 'yamlls',
  'html', 'terraform_lsp', 'denols',
  'kotlin_language_server', 'pyright', 
  'ts_ls'
}


local function buffer_augroup(group, bufnr, cmds)
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
  for _, cmd in ipairs(cmds) do
    local event = cmd.event
    cmd.event = nil
    vim.api.nvim_create_autocmd(event, vim.tbl_extend("keep", { group = group, buffer = bufnr }, cmd))
  end
end


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'f', '<cmd>lua vim.lsp.buf.format { async = true}<CR>', opts)
  require 'illuminate'.on_attach(client)
  local detach = function()
    vim.lsp.buf_detach_client(bufnr, client.id)
  end
  buffer_augroup("entropitor:lsp:closing", bufnr, {
    { event = "BufDelete", callback = detach },
  })
end

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities=capabilities,
  }
end

lspconfig.rust_analyzer.setup({
  on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
})

lspconfig.pylsp.setup{
  settings = {
    pylsp = {
      configurationSources = "flake8",
      plugins = {
        rope_autoimport = {
          enabled = true
        },
        flake8 = {
          enabled = true
        }
      }
    }
  },
  on_attach=on_attach,
  capabilities=capabilities,
}

lspconfig.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = '/path/to/@vue/language-server',
        languages = { 'vue' },
      },
    },
  },
}

lspconfig.volar.setup {
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
}


lspconfig.jdtls.setup{
  cmd = {
    "/home/matteo/.local/opt/jdtls-launcher/jdtls/bin/jdtls",
    "-configuration", "/home/matteo/.local/opt/jdtls-launcher/jdtls/config_linux",
    "-data", "/home/matteo/.cache/jdtls/workspace",
    "--jvm-arg=-javaagent:/home/matteo/.config/nvim/dependencies/lombok.jar",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM"
  },
  single_file_support=false,
  on_attach=on_attach,
  capabilities=capabilities,
  filetypes = {'java'},
}



vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
-- Do not forget to use the on_attach function
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float()]]
vim.o.updatetime=1000




-- ####################################################################################################################################################################################
--                                                                           FLUTTER
-- ####################################################################################################################################################################################
require("flutter-tools").setup{
  lsp = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      enableSnippets = true,
      updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
    }
  }-- e.g. lsp_status capabilities
}

-- ####################################################################################################################################################################################
--                                                                           bufferline
-- ####################################################################################################################################################################################
vim.opt.termguicolors = true

require("bufferline").setup{
  options = {
    numbers = "ordinal",
    max_name_length = 18,
    separator_style = "slant",
    tab_size = 18,
    show_buffer_icons = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    groups = {
      options = {
        toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
      },
    },
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
        or (e == "warning" and " " or "" )
        s = s .. n .. sym
      end
      return s
    end,
    custom_filter = function(buf_number)
      if string.match(vim.fn.bufname(buf_number), "fish") or
        string.match(vim.fn.bufname(buf_number), "git") or
        string.match(vim.fn.bufname(buf_number), "Merginal") then
        return false
      else
        return true
      end
    end,
  }
}


-- ####################################################################################################################################################################################
--                                                                           VIM
-- ####################################################################################################################################################################################

vim.cmd[[filetype plugin indent on]]
vim.cmd[[set expandtab]]
vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2

vim.cmd[[set tabpagemax=10]]
vim.cmd[[set nocompatible]]
vim.cmd[[set number]]
vim.cmd[[xnoremap p pgvy]]
vim.g.VM_mouse_mappings = 1
vim.g.VM_leader = ","

-- ####################################################################################################################################################################################
--                                                                           autosave
-- ####################################################################################################################################################################################


require('auto-save').setup(
  {
    enabled = true,
    events = {"InsertLeave"},
    conditions = {
      exists = true,
      modifiable = true
    },
    on_off_commands = true,
  }
)


require("toggleterm").setup{
  direction = "float",
  start_in_insert = true,
  insert_mappings = true,
  close_on_exit = true,
  float_opts = {
    border = 'curved',
    winblend = 3,
  },

  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}


function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<leader><esc>', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
