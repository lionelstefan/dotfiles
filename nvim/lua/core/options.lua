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
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.smartindent = true
-- vim.o.copyindent = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.title = true
vim.o.cursorline = true
vim.o.showtabline = 2
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 10
vim.o.timeoutlen = 200
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
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp._foldexpr()"
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
