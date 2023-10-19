-- Remaps

local map = vim.api.nvim_set_keymap

map('n', '<leader>w', ':w<CR>', {noremap=true})
map('n', ';q', ':q<CR>',        {noremap=true})

-- Indent
map('n', '<Tab>', '>>',         {noremap=true})
map('n', '<S-Tab>', '<<',       {noremap=true})
map('v', '<Tab>', ':><CR>gv',   {noremap=true})
map('v', '<S-Tab>', ':<<CR>gv', {noremap=true})

-- clear highlight
map('n', '<esc>', ':nohlsearch<CR><esc>', {noremap=true})

-- replace
map('n', 'rr', ':%s/', {noremap=true})

-- Change working dir
map('n', 'cd', ':cd ', {noremap=true})

-- Buffer cycle
map('n', '<leader>1', ':bp<CR>', {noremap=false})
map('n', '<leader>2', ':bn<CR>', {noremap=false})
map('n', '<leader>q', ':bd<CR>', {noremap=false})

-- Telescope
map('n', 'ff', '<CMD>Telescope find_files hidden=true<CR>', {noremap=true})
map('n', 'fg', '<CMD>Telescope live_grep<CR>',              {noremap=true})
map('n', 'fb', '<CMD>Telescope buffers<CR>',                {noremap=true})
map('n', 'fw', '<CMD>Telescope file_browser<CR>',           {noremap=true})

-- Telescope Projects
map('n', 'cp', '<CMD>lua require("telescope").extensions.project.project{}<CR>', {noremap=true})

-- Scroll
map('n', '<C-j>', '10jzz0',      {noremap=true})
map('n', '<C-k>', '10kzz0',      {noremap=true})
map('n', '<PageUp>', '20kzz0',   {noremap=true})
map('n', '<PageDown>', '20jzz0', {noremap=true})

-- Easy SO %
map('n', '<leader>r', ':luafile ~/dotfiles/nvim/init.lua<cr><esc>', {noremap=true})

-- moving bunch of lines
map('v', 'J', ':m \'>+1<CR>gv=gv',     {noremap=true})
map('v', 'K', ':m \'<-2<CR>gv=gv',     {noremap=true})
map('i', '<C-K>', '<ESC>:m .-2<CR>==', {noremap=true})
map('i', '<C-J>', '<ESC>:m .+1<CR>==', {noremap=true})
map('n', '<leader>k', ':m .-2<CR>==',  {noremap=true})
map('n', '<leader>j', ':m .+1<CR>==',  {noremap=true})

-- LazyGit
map('n', 'lg', '<CMD>LazyGit <CR>', {noremap=true})

-- ToggleTerm
map('n', 'tt', '<CMD>ToggleTerm direction=float<CR>', {noremap = true})

-- align
local NS = { noremap = true, silent = true }

-- vim.keymap.set('x', 'aa', function() require'align'.align_to_char(1, true)             end, NS) -- Aligns to 1 character, looking left
-- vim.keymap.set('x', 'as', function() require'align'.align_to_char(2, true, true)       end, NS) -- Aligns to 2 characters, looking left and with previews
vim.keymap.set('x', 'as', function() require'align'.align_to_string(false, true, true) end, NS) -- Aligns to a string, looking left and with previews
-- vim.keymap.set('x', 'ar', function() require'align'.align_to_string(true, true, true)  end, NS) -- Aligns to a Lua pattern, looking left and with previews

vim.keymap.set('n', 'fo', ':foldopen<CR>')
vim.keymap.set('n', 'fc', ':foldclose<CR>')
