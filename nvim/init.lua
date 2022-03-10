vim.cmd[[
    syntax enable
    filetype indent on
    filetype plugin indent on
]]
-- vim.o.background=dark
vim.wo.colorcolumn = '80'
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
vim.o.updatetime = 100
vim.o.timeoutlen = 500
vim.o.wildmenu = true
vim.o.wildmode = 'full:longest'
vim.o.showcmd = true
-- vim.o.t_Co=256
vim.o.termguicolors = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scl = 'yes'
vim.o.completeopt = 'menu,menuone,noselect'

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
    Plug 'junegunn/vim-plug'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mhinz/vim-startify'
    Plug 'StanAngeloff/php.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'preservim/nerdcommenter'
    Plug 'sheerun/vim-polyglot'
    Plug('pineapplegiant/spaceduck', { branch = 'main' })
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'tpope/vim-fugitive'
    Plug 'p00f/nvim-ts-rainbow'
	Plug 'windwp/nvim-ts-autotag'
	Plug 'edkolev/tmuxline.vim'
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'psliwka/vim-smoothie'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-project.nvim'
    Plug 'Yggdroot/indentLine'
    Plug 'morhetz/gruvbox'
    Plug 'bluz71/vim-moonfly-colors'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    if vim.fn.has('nvim') == 1 or vim.fn.has('patch-8.0.902') == 1 then
      Plug 'mhinz/vim-signify'
    else
      Plug('mhinz/vim-signify', { branch = 'legacy' })
    end
    Plug 'ap/vim-css-color'
	Plug 'ThePrimeagen/git-worktree.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'tpope/vim-surround'
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
    Plug 'williamboman/nvim-lsp-installer'
vim.call('plug#end')

-- gruvbox
vim.cmd[[
    autocmd vimenter * ++nested colorscheme gruvbox
]]

vim.g['gruvbox_italic'] = 1
vim.g['gruvbox_bold'] = 0
vim.g['gruvbox_transparent_bg'] = 1
vim.g['gruvbox_contrast_dark'] = 'hard'
vim.g['gruvbox_contrast_light'] = 'soft'

-- Airline 
vim.g['airline_powerline_fonts'] = 1
vim.g['airline_section_c'] = '%F'
vim.g['airline_theme'] = 'gruvbox'
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#fugitiveline#enabled'] = 1
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
vim.g['airline#extensions#whitespace#enabled'] = 1
vim.g['airline#extensions#bufferline#enabled'] = 1
vim.g['airline#extensions#bufferline#overwrite_variables'] = 1

-- unicode symbols
vim.g['airline_left_sep'] = '»'
vim.g['airline_left_sep'] = '▶'
vim.g['airline_right_sep'] = '«'
vim.g['airline_right_sep'] = '◀'
vim.g['airline_symbols.colnr'] = ' ㏇:'
vim.g['airline_symbols.colnr'] = ' ℅:'
vim.g['airline_symbols.crypt'] = '🔒'
vim.g['airline_symbols.linenr'] = '☰'
vim.g['airline_symbols.linenr'] = ' ␊:'
vim.g['airline_symbols.linenr'] = ' ␤:'
vim.g['airline_symbols.linenr'] = '¶'
vim.g['airline_symbols.maxlinenr'] = ''
vim.g['airline_symbols.maxlinenr'] = '㏑'
vim.g['airline_symbols.branch'] = '⎇'
vim.g['airline_symbols.paste'] = 'ρ'
vim.g['airline_symbols.paste'] = 'Þ'
vim.g['airline_symbols.paste'] = '∥'
vim.g['airline_symbols.whitespace'] = 'Ξ'

-- airline symbols
vim.g['airline_left_sep'] = ''
vim.g['airline_left_alt_sep'] = ''
vim.g['airline_right_sep'] = ''
vim.g['airline_right_alt_sep'] = ''
vim.g['airline_symbols.branch'] = ''
vim.g['airline_symbols.readonly'] = ''
vim.g['airline_symbols.linenr'] = ''
vim.g['airline_symbols.colnr'] = ' :'
vim.g['airline_symbols.readonly'] = ''
vim.g['airline_symbols.linenr'] = ' :'
vim.g['airline_symbols.maxlinenr'] = '☰ '
vim.g['airline_symbols.dirty'] ='⚡'

-- PHP VIM
vim.g['php_var_selector_is_identifier'] = 1
vim.g['php_html_load'] = 1
vim.g['php_sql_query'] = 1

-- NERDCommenter
vim.g['NERDTrimTrailingWhitespace'] = 1
vim.g['NERDCreateDefaultMappings'] = 1
vim.g['NERDCompactSexyComs'] = 1
vim.g['NERDSpaceDelims'] = 1
vim.g['NERDCommentEmptyLines'] = 1
vim.g['NERDCommentEmptyLines'] = 0
vim.g['NERDToggleCheckAllLines'] = 1

require'nvim-treesitter.configs'.setup {
ensure_installed = {
    "php",
    "json",
    "html",
    "css",
    "javascript",
    "tsx",
    "scss",
    "typescript",
    "yaml",
    "python"
  },
  autotag = {
	enable = true,
  },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  }
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension "git_worktree"
require("telescope").load_extension "project"

local actions = require("telescope.actions")
require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["qq"] = actions.close,
                ["|"] = actions.file_vsplit,
                ["_"] = actions.file_split
            },
        }
    }
}
local on_attach = function( client, bufnr )
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = {
        noremap=true,
        silent=true,
    }

    buf_set_keymap('n', 'kf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local servers = {
    'intelephense',
    'psalm',
    'phpactor',
    'html',
    'cssls',
    'jsonls',
    'vimls'
}

local cmp = require("cmp")

require("cmp").setup({
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
	sources = {
			{ name = 'nvim_lsp' },
			{ name = 'buffer' }
	}
})

cmp.setup.cmdline('/', {
    sources = {
		{ name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
		{ name = 'path' }
    }, {
		{ name = 'cmdline' }
    })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup{
        on_attach = on_attach,
		capabilities = capabilities
    }
end

-- Startify
vim.g.startify_lists = {
    { type= 'files',     header= {'   Recently opened files'}                    },
    { type= 'dir',       header= {'   Recently opened project files '.. vim.fn.getcwd()} },
    { type= 'sessions', header= {'   Sessions'}                                 },
    { type= 'bookmarks', header= {'   Bookmarks'}                                },
    { type= 'commands',  header= {'   Commands'}                                 },
}

vim.g.startify_bookmarks = {
   '~/dotfiles/nvim/init.lua',
   '~/dotfiles/.zshrc',
}


-- highlight yank
vim.cmd[[
    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
    augroup END
]]

-- Remaps

local map = vim.api.nvim_set_keymap
map('n', ';w', ':w<CR>', {noremap=true})
map('n', ';q', ':q<CR>', {noremap=true})

-- Indent
map('n', '<Tab>', '>>', {noremap=true})
map('n', '<S-Tab>', '<<', {noremap=true})
map('v', '<Tab>', '>>', {noremap=true})
map('v', '<S-Tab>', '<<', {noremap=true})

-- replace
map('n', 'rr', ':%s/', {noremap=true})

-- Change working dir
map('n', 'cd', ':cd', {noremap=true})

-- Buffer cycle
map('n', 'bn', ':bn<CR>', {noremap=false})
map('n', 'bp', ':bp<CR>', {noremap=false})
map('n', 'qq', ':bd<CR>', {noremap=false})

-- Telescope
map('n', 'ff', '<CMD>Telescope find_files<CR>', {noremap=true})
map('n', 'fg', '<CMD>Telescope live_grep<CR>', {noremap=true})
map('n', 'fb', '<CMD>Telescope buffers<CR>', {noremap=true})
map('n', 'fw', '<CMD>Telescope file_browser<CR>', {noremap=true})

-- Telescope Projects
map('n', 'cp', '<CMD>lua require("telescope").extensions.project.project{}<CR>', {noremap=true})

-- NERDCommenter 
map('n', 'cc', '<CMD>call nerdcommenter#Comment("n","toggle")<CR>', {noremap=true})
map('v', 'cc', '<CMD>call nerdcommenter#Comment("x","toggle")<CR>', {noremap=true})

-- Scroll
map('n', '<C-j>', '10jzz0', {noremap=true})
map('n', '<C-k>', '10kzz0', {noremap=true})
map('n', '<PageUp>', '20kzz0', {noremap=true})
map('n', '<PageDown>', '20jzz0', {noremap=true})

-- Easy SO %
map('n', '<leader>r', ':so ~/dotfiles/nvim/init.lua<cr><esc>', {noremap=true})

-- moving bunch of lines
map('v', 'J', ':m \'>+1<CR>gv=gv', {noremap=true})
map('v', 'K', ':m \'<-2<CR>gv=gv', {noremap=true})
map('i', '<C-K>', '<ESC>:m .-2<CR>==', {noremap=true})
map('i', '<C-J>', '<ESC>:m .+1<CR>==', {noremap=true})
map('n', '<leader>k', ':m .-2<CR>==', {noremap=true})
map('n', '<leader>j', ':m .+1<CR>==', {noremap=true})
