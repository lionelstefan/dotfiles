-- DISABLE BUILTIN PLUGIN
vim.g["loaded_2html_plugin"] = 1
vim.g["loaded_getscript"] = 1
vim.g["loaded_getscriptPlugin"] = 1
vim.g["loaded_gzip"] = 1
vim.g["loaded_logipat"] = 1
vim.g["loaded_netrw"] = 1
vim.g["loaded_netrwPlugin"] = 1
vim.g["loaded_netrwSettings"] = 1
vim.g["loaded_netrwFileHandlers"] = 1
vim.g["loaded_matchit"] = 1
vim.g["loaded_matchparen"] = 1
vim.g["loaded_tar"] = 1
vim.g["loaded_tarPlugin"] = 1
vim.g["loaded_rrhelper"] = 1
vim.g["loaded_vimball"] = 1
vim.g["loaded_vimballPlugin"] = 1
vim.g["loaded_zip"] = 1
vim.g["loaded_zipPlugin"] = 1

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
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.lazyredraw = false
vim.o.scrolloff = 7
vim.o.undofile = true
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.o.list = true

-- GITBLAME
vim.g['gitblame_enabled'] = 1
vim.g['gitblame_message_template'] = '<author> • <sha> • <date> • <summary>'

-- PHP VIM
vim.g['php_var_selector_is_identifier'] = 1
vim.g['php_html_load'] = 1
vim.g['php_sql_query'] = 1

-- GRUVBOX BABY
vim.g['gruvbox_baby_function_style'] = "NONE"
vim.g['gruvbox_baby_background_color'] = "dark"
vim.g['gruvbox_baby_comment_style'] = "NONE"

-- gruvbox
-- autocmd vimenter * ++nested colorscheme gruvbox8_hard
-- autocmd VimEnter * ++nested colorscheme gruvbox
-- autocmd BufEnter * ++nested colorscheme gruvbox-baby
-- colorscheme gruvbox
vim.cmd[[
    autocmd BufEnter * syntax enable
    autocmd BufEnter * filetype indent on
    autocmd BufEnter * filetype plugin indent on
    colorscheme gruvbox-baby
]]

-- require("plugins.nerdcommenter")
require("plugins.treesitter")
require("plugins")
require("remaps")
