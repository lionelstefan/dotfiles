vim.o.background = "dark"
vim.o.colorcolumn = "120"
vim.o.path = vim.o.path .. "**"
vim.o.cmdheight = 2
vim.o.hidden = true
vim.o.clipboard = "unnamedplus"
vim.o.wrap = true
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.ruler = true
vim.o.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.conceallevel = 0
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.autoindent = true
-- vim.o.copyindent = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.title = true
vim.o.cursorline = true
vim.o.showtabline = 2
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 100
vim.o.timeoutlen = 300
vim.o.wildmenu = true
vim.o.wildmode = "full:longest"
vim.o.showcmd = false
-- vim.o.t_ut = ""
vim.o.termguicolors = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scl = "yes"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.scrolloff = 10
vim.o.undofile = true
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
-- vim.o.list           = true
vim.o.textwidth = 80
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.mouse = ""
-- vim.o.fillchars = "fold: "
-- vim.o.fcs= "fold: "
-- vim.opt.fcs = {
--   eob = " ",
--   fold = " ",
--   foldopen = "▼",
--   foldsep = "|",
--   foldclose = "▶",
-- }
vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "▼",
  foldsep = "|",
  foldclose = "▶",
}
vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
end

vim.g.clipboard = {
	name = "win32yank-wsl",
	copy = {
		["+"] = "win32yank.exe -i --crlf",
		["*"] = "win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "win32yank.exe -o --lf",
		["*"] = "win32yank.exe -o --lf",
	},
	cache_enabled = 0,
}

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
vim.lsp.set_log_level("off")

vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

require("plugins")

vim.notify = require("notify")

-- GITBLAME
vim.g["gitblame_enabled"] = 1
vim.g["gitblame_message_template"] = "<author> • <summary> • <sha> • <date> "
vim.g["gitblame_delay"] = 1000
vim.g["gitblame_virtual_text_column"] = 80

-- CONTEXT COMMENTSTRING
vim.g["skip_ts_context_commentstring_module"] = true

-- LAZYGIT
vim.g["lazygit_floating_window_scaling_factor"] = 1

require("gruvbox").setup({
	undercurl = false,
	underline = false,
	italic = {
		comments = true,
		strings = false,
		operators = false,
		folds = false,
	},
	bold = false,
	contrast = "hard",
})

vim.cmd([[
	autocmd VimEnter * ++nested colorscheme gruvbox
]])

vim.cmd([[
	autocmd VimEnter * ++nested set fcs=eob:\ ,fold:\ 
]])

vim.cmd([[
	autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
]])

vim.cmd([[
	autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
]])

vim.cmd([[
	autocmd FileType vue setlocal ts=2 sts=2 sw=2 expandtab
]])

vim.cmd([[
	autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
]])

vim.cmd([[
    colorscheme gruvbox
]])

vim.cmd([[
	autocmd ColorScheme * highlight SignColumn guibg=NONE
]])

require("remaps")
