-- Core keymaps (non-plugin specific)
-- Plugin-specific keymaps should be in plugin specs or LSP on_attach

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

local function map_nr(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, desc = desc })
end

local function map_ns(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Save and quit
map_nr("n", "<leader>w", ":w!<CR>", "Save file")
map_nr("n", ";q", ":q<CR>", "Quit")

-- Indent
map_nr("n", "<Tab>", ">>", "Indent right")
map_nr("n", "<S-Tab>", "<<", "Indent left")
map_nr("v", "<Tab>", ":><CR>gv", "Indent right")
map_nr("v", "<S-Tab>", ":<<CR>gv", "Indent left")

-- Clear highlight
map_nr("n", "<esc>", ":nohlsearch<CR><esc>", "Clear search highlight")

-- Replace
map_nr("n", "rr", ":%s/", "Global replace")

-- Change working dir
map_nr("n", "cd", ":cd ", "Change directory")

-- Bufferline
map("n", "<leader>1", ":BufferLineCyclePrev<CR>", "Previous buffer")
map("n", "<leader>2", ":BufferLineCycleNext<CR>", "Next buffer")

-- Buffer cycle with mini.bufremove
map("n", "<leader>q", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
  local buflisted = vim.fn.buflisted(bufnr) == 1

  if buftype == "" and buflisted then
    -- Normal listed buffer: use MiniBufremove
    require("mini.bufremove").delete(bufnr, false)
  else
    -- Special buffer (nofile, terminal, etc.): use plain :bd
    vim.cmd("bd")
  end
end, "Close buffer or :bd for special")

map_ns("n", "<leader>Q", "<cmd>q!<CR>", "Force quit")

-- Scroll
map_nr("n", "<C-j>", "10jzz0", "Scroll down")
map_nr("n", "<C-k>", "10kzz0", "Scroll up")
map_nr("n", "<PageUp>", "10kzz0", "Page up")
map_nr("n", "<PageDown>", "10jzz0", "Page down")

-- Easy reload config
map_nr("n", "<leader>r", ":luafile ~/dotfiles/nvim-optimize/init.lua<cr><esc>", "Reload config")

-- Reopen file
map_nr("n", "<leader>e", "<cmd>e<cr>", "Reopen file")

-- Moving lines
map_nr("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map_nr("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map_nr("i", "<C-K>", "<ESC>:m .-2<CR>==", "Move line up")
map_nr("i", "<C-J>", "<ESC>:m .+1<CR>==", "Move line down")
map_nr("n", "<leader>k", ":m .-2<CR>==", "Move line up")
map_nr("n", "<leader>j", ":m .+1<CR>==", "Move line down")

-- Fold
map_ns("n", "<leader>zz", "za", "Toggle fold")

-- Clear search highlight
map_ns("n", "<Leader>l", "<Cmd>noh<CR>", "Clear search")

-- PHP DOCBLOCK (if function exists)
map_ns("n", "<Leader>db", ":lua add_phpdoc_comment()<CR>", "Add PHP docblock")

-- Smart indent after paste
map_ns("n", "p", "p`[v`]=`]", "Paste and indent")
map_ns("n", "P", "P`[v`]=`]", "Paste before and indent")

-- Smart indent after visual mode paste
map_ns("x", "p", '"_dP`[v`]=`]', "Paste without yank")
map_ns("x", "P", '"_dP`[v`]=`]', "Paste before without yank")

-- Window navigation (DAP movement style)
map_ns("n", "<C-Up>", "<C-w>k", "Move to window above")
map_ns("n", "<C-Down>", "<C-w>j", "Move to window below")
map_ns("n", "<C-Left>", "<C-w>h", "Move to window left")
map_ns("n", "<C-Right>", "<C-w>l", "Move to window right")

-- Better window navigation (original style)
map("n", "<C-h>", "<C-w>h", "Move to left window")
map("n", "<C-j>", "<C-w>j", "Move to bottom window")
map("n", "<C-k>", "<C-w>k", "Move to top window")
map("n", "<C-l>", "<C-w>l", "Move to right window")

-- Resize windows
map("n", "<C-Up>", ":resize -2<CR>", "Resize window up")
map("n", "<C-Down>", ":resize +2<CR>", "Resize window down")
map("n", "<C-Left>", ":vertical resize -2<CR>", "Resize window left")
map("n", "<C-Right>", ":vertical resize +2<CR>", "Resize window right")

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", "Next buffer")
map("n", "<S-h>", ":bprevious<CR>", "Previous buffer")
map("n", "<leader>bd", ":bdelete<CR>", "Delete buffer")

-- Stay in indent mode
map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", "Move line down")
map("v", "<A-k>", ":m .-2<CR>==", "Move line up")
map("x", "J", ":move '>+1<CR>gv-gv", "Move selection down")
map("x", "K", ":move '<-2<CR>gv-gv", "Move selection up")
map("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move selection down")
map("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move selection up")

-- Better paste
map("v", "p", '"_dP', "Paste without yanking")

-- Clear search highlighting
map("n", "<leader>h", ":nohlsearch<CR>", "Clear search highlight")

-- Quick save
map("n", "<leader>w", ":w<CR>", "Save file")

-- Quit
map("n", "<leader>q", ":q<CR>", "Quit")
map("n", "<leader>Q", ":qa!<CR>", "Force quit all")

-- Split management
map("n", "<leader>sv", ":vsplit<CR>", "Vertical split")
map("n", "<leader>sh", ":split<CR>", "Horizontal split")
map("n", "<leader>se", "<C-w>=", "Equalize splits")
map("n", "<leader>sx", ":close<CR>", "Close split")

-- DAP HOVER (conditional setup)
map("n", "<C-k>", function()
  local ok, dap = pcall(require, "dap.ui.widgets")
  if ok then
    local hover = dap.hover()
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<Cmd>close<CR>", { noremap = true, silent = true })
  end
end, "DAP hover or move up")