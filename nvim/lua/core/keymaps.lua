-- Remaps

local map = vim.keymap.set
local NS = { noremap = true, silent = true }
local NR = { noremap = true }

map("n", "<leader>w", ":w!<CR>", NR)
map("n", ";q", ":q<CR>", NR)

-- Indent
map("n", "<Tab>", ">>", NR)
map("n", "<S-Tab>", "<<", NR)
map("v", "<Tab>", ":><CR>gv", NR)
map("v", "<S-Tab>", ":<<CR>gv", NR)

-- clear highlight
map("n", "<esc>", ":nohlsearch<CR><esc>", NR)

-- replace
map("n", "rr", ":%s/", NR)

-- Change working dir
map("n", "cd", ":cd ", NR)

-- Bufferline
map("n", "<leader>1", ":BufferLineCyclePrev<CR>", { noremap = false })
map("n", "<leader>2", ":BufferLineCycleNext<CR>", { noremap = false })

-- Buffer cycle
map("n", "<leader>q", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
  local buflisted = vim.fn.buflisted(bufnr) == 1

  if vim.bo.filetype == "vim" and vim.bo.buftype == "nofile" then
    vim.cmd("q")
  elseif vim.bo.buftype == "" and vim.bo.buflisted then
    -- Normal listed buffer: use MiniBufremove
    require("mini.bufremove").delete(bufnr, false)
  else
    -- Special buffer (terminal, help, etc.): plain :bd
    vim.cmd("bd")
  end
end, { noremap = true, desc = "Close buffer or :bd for special" })
map("n", "<leader>Q", "<cmd>q!<CR>", { noremap = true, silent = true })

-- Scroll
map("n", "<C-j>", "10jzz0", NR)
map("n", "<C-k>", "10kzz0", NR)
map("n", "<PageUp>", "10kzz0", NR)
map("n", "<PageDown>", "10jzz0", NR)

-- Easy SO %
map("n", "<leader>r", ":luafile ~/dotfiles/nvim/init.lua<cr><esc>", NR)

-- reopen file
map("n", "<leader>e", "<cmd>e<cr>", NR)

-- moving bunch of lines
map("v", "J", ":m '>+1<CR>gv=gv", NR)
map("v", "K", ":m '<-2<CR>gv=gv", NR)
map("i", "<C-K>", "<ESC>:m .-2<CR>==", NR)
map("i", "<C-J>", "<ESC>:m .+1<CR>==", NR)
map("n", "<leader>k", ":m .-2<CR>==", NR)
map("n", "<leader>j", ":m .+1<CR>==", NR)

-- align

-- vim.keymap.set('x', 'aa', function() require'align'.align_to_char(1, true)             end, NS) -- Aligns to 1 character, looking left
-- vim.keymap.set('x', 'as', function() require'align'.align_to_char(2, true, true)       end, NS) -- Aligns to 2 characters, looking left and with previews
-- vim.keymap.set('x', 'ar', function() require'align'.align_to_string(true, true, true)  end, NS) -- Aligns to a Lua pattern, looking left and with previews

map("n", "<leader>zz", "za", { noremap = true, silent = true })

map("n", "<Leader>l", "<Cmd>noh<CR>", NS)

-- PHP DOCBLOCK
map("n", "<Leader>db", ":lua add_phpdoc_comment()<CR>", NS)

-- Smart indent after normal mode paste
map("n", "p", "p`[v`]=`]", { noremap = true, silent = true })
map("n", "P", "P`[v`]=`]", { noremap = true, silent = true })

-- Smart indent after visual mode paste
map("x", "p", '"_dP`[v`]=`]', { noremap = true, silent = true })
map("x", "P", '"_dP`[v`]=`]', { noremap = true, silent = true })

-- DAP MOVEMENT
map('n', '<C-Up>',    '<C-w>k', { noremap = true, silent = true })
map('n', '<C-Down>',  '<C-w>j', { noremap = true, silent = true })
map('n', '<C-Left>',  '<C-w>h', { noremap = true, silent = true })
map('n', '<C-Right>', '<C-w>l', { noremap = true, silent = true })

-- DAP HOVER
map("n", "<C-k>", function()
  local widgets = require("dap.ui.widgets")
  local hover = widgets.hover()
  vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<Cmd>close<CR>", { noremap = true, silent = true })
end)
