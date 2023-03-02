-- DISABLE BUILTIN PLUGIN
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
vim.o.lazyredraw = true
vim.o.scrolloff = 7
vim.o.undofile = true
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.o.list = true

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

require("plugins")

-- GITBLAME
vim.g['gitblame_enabled'] = 1
vim.g['gitblame_message_template'] = '<author> • <sha> • <date> • <summary>'

-- PHP VIM
vim.g['php_var_selector_is_identifier'] = 1
vim.g['php_html_load'] = 1
vim.g['php_sql_query'] = 1

-- GRUVBOX BABY
-- vim.g['gruvbox_baby_function_style'] = "NONE"
-- vim.g['gruvbox_baby_background_color'] = "dark"
-- vim.g['gruvbox_baby_comment_style'] = "NONE"
-- autocmd VimEnter * ++nested colorscheme gruvbox

require'gruvbox'.setup({
	undercurl = false,
	underline = false,
	italic = false,
	bold = false,
	contrast = "hard",
})

vim.cmd[[
    autocmd VimEnter * syntax enable
    autocmd VimEnter * filetype indent on
    autocmd VimEnter * filetype plugin indent on
	colorscheme gruvbox
	augroup end
]]

-- require("plugins.nerdcommenter")
require("remaps")
