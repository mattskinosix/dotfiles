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
  { 'uga-rosa/translate.nvim' },
  { 'knubie/vim-kitty-navigator' },
  { 'mfussenegger/nvim-dap' },
  { 'Pocco81/dap-buddy.nvim' },
  { 'renerocksai/telekasten.nvim' },
  {
    'kyazdani42/nvim-tree.lua',
  },
  { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'},
  {
    "NTBBloodbath/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "vim-test/vim-test" },
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
   {'akinsho/flutter-tools.nvim', dependencies = 'nvim-lua/plenary.nvim'},
   { "nvim-telescope/telescope-media-files.nvim" },
  -- Add indentation guides even on blank lines
   { "lukas-reineke/indent-blankline.nvim" },
  -- Add git related info in the signs columns and popups
   { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  ({"petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim"}),
   { 'SirVer/ultisnips' },
   { 'honza/vim-snippets' },
   {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-nvim-lsp",
          "quangnguyen30192/cmp-nvim-ultisnips",
          "hrsh7th/cmp-nvim-lua",
          "octaltree/cmp-look",
          "hrsh7th/cmp-path",
          "f3fora/cmp-spell",
          "hrsh7th/cmp-emoji",
          "ray-x/cmp-treesitter",
          "uga-rosa/cmp-dictionary",
          "hrsh7th/cmp-cmdline",
          "hrsh7th/cmp-nvim-lsp-document-symbol",
        },
      },
   'nvim-treesitter/nvim-treesitter',
   'nvim-treesitter/nvim-treesitter-textobjects',
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
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
  },
  {'akinsho/toggleterm.nvim', version = "*", config = true}
})



vim.notify = require "notify"

require('dashboard').setup {
}

require("cmp_nvim_ultisnips").setup{
  filetype_source = "treesitter",
  show_snippets = "all",
  documentation = function(snippet)
    return snippet.description
  end 
}

require("trouble").setup {
  position = "bottom", -- position of the list can be: bottom, top, left, right
  height = 10, -- height of the trouble list when position is top or bottom
  width = 50, -- width of the list when position is left or right
  icons = true, -- use devicons for filenames
  mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
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

require("rest-nvim").setup({
  -- Open request results in a horizontal split
  result_split_horizontal = false,
  -- Skip SSL verification, useful for unknown certificates
  skip_ssl_verification = false,
  -- Highlight request on run
  highlight = {
    enabled = true,
    timeout = 150,
  },
  result = {
    -- toggle showing URL, HTTP info, headers at top the of result window
    show_url = true,
    show_http_info = true,
    show_headers = true,
  },
  -- Jump to request line on run
  jump_to_request = false,
  env_file = '.env',
  custom_dynamic_variables = {},
  yank_dry_run = true,
})
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
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    show_trailing_blankline_indent = false,
}


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

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

-- ####################################################################################################################################################################################
--                                                                           CMP
-- ####################################################################################################################################################################################

local cmp = require 'cmp'
-- nvim-cmp setup
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- lsp_document_symbols
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
      ['<Up>'] = cmp.mapping.select_prev_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
      { name = 'nvim_lsp', priority=30},
      { name = 'ultisnips', priority=25 }, -- For ultisnips users.
      { name = 'emoji', priority=15 },
      { name = 'path', priority=10 },
    }
  )
}

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
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
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
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
-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,  
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
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatic/ally jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
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
vim.api.nvim_set_keymap('n', '<leader>m', [[<cmd>Merginal<CR>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', [[<Plug>RestNvim]], { noremap = false, silent = true })
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
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
end



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
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local lspconfig = require('lspconfig')
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'vuels', 'cssls', 'dockerls', 'yamlls', 'html', 'svelte', 'denols', 'pylsp'}

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities=capabilities,
    single_file_support = true,
  }
end

lspconfig.jdtls.setup{
  cmd = { 'jdtls' },
  init_options = {
    jvm_args = {
      "~/.config/nvim/dependencies/lombok.jar"
    },
    workspace = "~/.cache/jdtls/workspace"
  },
  on_attach=on_attach,
  capabilities=capabilities,
}


lspconfig.eslint.setup({
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro", "python" },
})

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
vim.diagnostic.config({
  virtual_text = false,
  signs = true ,
  underline = true,
  severity_sort = true,
})
-- ####################################################################################################################################################################################
--                                                                           FLUTTER
-- ####################################################################################################################################################################################

require("flutter-tools").setup{
  lsp = {
    on_attach = on_attach,
    capabilities = capabilities 
  }-- e.g. lsp_status capabilities
}
-- ####################################################################################################################################################################################
--                                                                           Prettier
-- ####################################################################################################################################################################################

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


-- ####################################################################################################################################################################################
--                                                                           autosave
-- ####################################################################################################################################################################################


require('auto-save').setup(
  {
    enabled = true,
    execution_message = {
      message = function() -- message to print on save
        return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
      end,
      dim = 0.18, -- dim the color of `message`
      cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
    },
    events = {"InsertLeave"},
    conditions = {
      exists = true,
      modifiable = true
    },
    write_all_buffers = true,
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

require'switch_case'
vim.api.nvim_set_keymap('n', '<Leader>s', '<cmd>lua require("switch_case").switch_case()<CR>', {noremap = true, silent = true})
