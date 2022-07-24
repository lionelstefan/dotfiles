vim.o.background = 'dark'
vim.o.colorcolumn = '80'
vim.o.path = vim.o.path .. '**'
vim.o.confirm = true
vim.o.cmdheight = 2
vim.o.hidden = true
vim.o.clipboard = 'unnamedplus'
vim.o.wrap = false
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.ruler = true
vim.o.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.conceallevel = 0
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.copyindent = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.title = true
vim.o.cursorline = true
vim.o.showtabline = 2
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 200
vim.o.timeoutlen = 500
vim.o.wildmenu = true
vim.o.wildmode = 'full:longest'
vim.o.showcmd = true
vim.o.t_ut = ''
vim.o.termguicolors = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scl = 'yes'
vim.o.completeopt =  'menu,menuone,noselect' 
vim.o.lazyredraw = true
vim.o.scrolloff = 7
vim.o.undofile = true
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.cmd[[highlight IndentBlankLineIndent1 guifg=#666666 gui=nocombine]]
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    char_highlight_list = {
        "IndentBlankLineIndent1"
    }
}

vim.o.list = true
vim.opt.listchars:append("space:⋅")

require("plugins")
require("impatient")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.nerdcommenter")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.bufferline")

-- gruvbox
-- autocmd vimenter * ++nested colorscheme gruvbox8_hard
vim.cmd[[
    autocmd VimEnter * ++nested colorscheme gruvbox
    colorscheme gruvbox
    syntax enable
    filetype indent on
    filetype plugin indent on
]]

-- GITBLAME
vim.g['gitblame_enabled'] = 1
vim.g['gitblame_message_template'] = '<author> • <sha> • <date> • <summary>'

-- PHP VIM
vim.g['php_var_selector_is_identifier'] = 1
vim.g['php_html_load'] = 1
vim.g['php_sql_query'] = 1

require("remaps")
