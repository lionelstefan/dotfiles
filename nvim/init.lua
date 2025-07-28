vim.cmd([[
  syntax off
  filetype off
  filetype plugin indent off
]])

require('options.options')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.lsp.set_log_level("warn")

require("lazy-setup")
require("configs.docblock")
require("configs.global-configs")
require("autocmds.autocmds")
require("remaps")

vim.cmd([[
  syntax on
  filetype on
  filetype plugin indent on
]])

vim.cmd([[
  autocmd User TelescopePreviewerLoaded setlocal number
]])
