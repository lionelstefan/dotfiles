-- Remaps

local map = vim.api.nvim_set_keymap
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

-- Buffer cycle
map("n", "<leader>1", ":BufferLineCyclePrev<CR>", { noremap = false })
map("n", "<leader>2", ":BufferLineCycleNext<CR>", { noremap = false })
map("n", "<leader>q", ":lua MiniBufremove.delete()<CR>", { noremap = false })
map("n", "<leader>qa", ":bd<CR>", { noremap = false })

-- Harpoon
map("n", "<leader>dh", ':lua require("harpoon"):list():clear()<CR>', { noremap = false })

-- NeoTree
map("n", "<leader>b", ":Neotree float<CR>", { noremap = false })

-- Telescope
map("n", "ff", "<CMD>Telescope find_files hidden=true previewer=false layout_config={width=0.8}<CR>", NR)
map("n", "fg", "<CMD>Telescope live_grep layout_config={width=0.95}<CR>", NR)
map("n", "fb", "<CMD>Telescope buffers<CR>", NR)
map("n", "fp", "<CMD>Telescope projects<CR>", NR)

-- Telescope Projects
map("n", "cp", '<CMD>lua require("telescope").extensions.project.project{}<CR>', NR)

-- Scroll
map("n", "<C-j>", "10jzz0", NR)
map("n", "<C-k>", "10kzz0", NR)
map("n", "<PageUp>", "10kzz0", NR)
map("n", "<PageDown>", "10jzz0", NR)

-- Easy SO %
map("n", "<leader>r", ":luafile ~/dotfiles/nvim/init.lua<cr><esc>", NR)

-- moving bunch of lines
map("v", "J", ":m '>+1<CR>gv=gv", NR)
map("v", "K", ":m '<-2<CR>gv=gv", NR)
map("i", "<C-K>", "<ESC>:m .-2<CR>==", NR)
map("i", "<C-J>", "<ESC>:m .+1<CR>==", NR)
map("n", "<leader>k", ":m .-2<CR>==", NR)
map("n", "<leader>j", ":m .+1<CR>==", NR)

-- LazyGit
map("n", "lg", "<CMD>LazyGit <CR>", NR)

-- ToggleTerm
map("n", "tt", "<CMD>ToggleTerm<CR>", NR)

-- align

-- vim.keymap.set('x', 'aa', function() require'align'.align_to_char(1, true)             end, NS) -- Aligns to 1 character, looking left
-- vim.keymap.set('x', 'as', function() require'align'.align_to_char(2, true, true)       end, NS) -- Aligns to 2 characters, looking left and with previews
vim.keymap.set("x", "as", function()
	require("align").align_to_string(false, true, true)
end, NS) -- Aligns to a string, looking left and with previews
-- vim.keymap.set('x', 'ar', function() require'align'.align_to_string(true, true, true)  end, NS) -- Aligns to a Lua pattern, looking left and with previews

vim.keymap.set("n", "fo", ":foldopen<CR>")
vim.keymap.set("n", "fc", ":foldclose<CR>")

-- HLSLENS

map(
	"n",
	"n",
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	NS
)
map(
	"n",
	"N",
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	NS
)
map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], NS)
map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], NS)
map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], NS)
map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], NS)

map("n", "<Leader>l", "<Cmd>noh<CR>", NS)

-- NEOGEN PHP DOCBLOCK
map("n", "<Leader>dc", ":lua require('neogen').generate({ type = 'class' })<CR>", NS)
