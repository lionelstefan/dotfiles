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

vim.cmd([[
	autocmd VimEnter * highlight TreesitterContext guibg=#353A3C
]])

vim.cmd([[
  autocmd BufWritePre * lua require("conform").format({ async = true, timeout_ms = 500, formatters = { "trim_whitespace", "trim_newlines" } })
]])
