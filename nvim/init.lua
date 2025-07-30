vim.cmd([[
  syntax off
  filetype plugin indent off
]])

require("core.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

require("plugins")

require("core.diagnostics")
require("core.keymaps")
require("core.autocmds")

vim.cmd([[
  syntax on
  filetype plugin indent on
]])

vim.cmd([[
  autocmd User TelescopePreviewerLoaded setlocal number
]])
