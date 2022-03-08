syntax enable
filetype indent on
filetype plugin indent on
" set background=dark
set colorcolumn=80
set path+=**
set confirm
set cmdheight=2
set hidden
set clipboard=unnamedplus
set nowrap
set encoding=utf-8
set fileencoding=utf-8
set ruler
set relativenumber
set splitbelow
set conceallevel=0
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set autoindent
set copyindent
set laststatus=2
set number
set title
set cursorline
set showtabline=2
set nobackup
set nowritebackup
set updatetime=100
set timeoutlen=500
set wildmenu
set wildmode=full:longest
set showcmd
" set t_Co=256
set termguicolors
set hlsearch
set incsearch
set ignorecase
set smartcase
set scl=yes

call plug#begin()
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
    Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'tpope/vim-fugitive'
    Plug 'p00f/nvim-ts-rainbow'
	Plug 'windwp/nvim-ts-autotag'
	Plug 'edkolev/tmuxline.vim'
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'psliwka/vim-smoothie'
	Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-project.nvim'
    Plug 'Yggdroot/indentLine'
    Plug 'morhetz/gruvbox'
    Plug 'bluz71/vim-moonfly-colors'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    if has('nvim') || has('patch-8.0.902')
      Plug 'mhinz/vim-signify'
    else
      Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
    endif
    Plug 'ap/vim-css-color'
	Plug 'ThePrimeagen/git-worktree.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

"gruvbox
" autocmd vimenter * ++nested colorscheme gruvbox
" let g:gruvbox_italic=1
" let g:gruvbox_transparent_bg = 1
" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_contrast_light = 'soft'

colorscheme spaceduck

" Airline 
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%F'
let g:airline_theme = 'challenger_deep'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1

"Tmuxline
let g:tmuxline_theme = 'molokai'

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

"PHP VIM
let php_var_selector_is_identifier = 1
let php_html_load = 1
let php_sql_query = 1

"NERDCommenter
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCreateDefaultMappings = 1
let g:NERDCompactSexyComs = 1
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDCommentEmptyLines = 0
let g:NERDToggleCheckAllLines = 1
let g:NERDCompactSexyComs = 1

"Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
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
EOF

"Startify
let g:startify_lists = [
    \ { 'type': 'files',     'header': ['   Recently opened files']                    },
    \ { 'type': 'dir',       'header': ['   Recently opened project files '. getcwd()] },
    \ { 'type': 'sessions', 'header': ['   Sessions']                                 },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                                },
    \ { 'type': 'commands',  'header': ['   Commands']                                 },
    \ ]

let g:startify_bookmarks = [
  \ '~/dotfiles/nvim/init.vim',
  \ '~/dotfiles/.zshrc',
\ ]

let g:startify_custom_header = [
    \           '                   _                ',
    \           '   \\       _   __(_)___ ___   \\   ',
    \           '    \\     | | / / / __ `__ \   \\  ',
    \           '     \\    | |/ / / / / / / /    \\ ',
    \           '      \\   |___/_/_/ /_/ /_/      \\',
    \           '       ++++++++=============++++++++',   
    \           '            Explore Projects   ',
    \ ]

"Telescope
nnoremap <silent> ff :Telescope find_files<CR>
nnoremap <silent> fg :Telescope live_grep<CR>
nnoremap <silent> fb :Telescope buffers<CR>
nnoremap <silent> fw :Telescope file_browser<CR>

"highlight yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
augroup END

"Remaps
"Indent
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >>
vnoremap <S-Tab> <<

"replace
nnoremap rr :%s/

"Change working dir
nnoremap cd :cd 

"Buffer cycle
map bn :bn<cr>
map bp :bp<cr>
map bd :bd<cr> 

"Telescope Projects
nnoremap cp :lua require'telescope'.extensions.project.project{}<CR>

"NERDCommenter 
vnoremap cc :call nerdcommenter#Comment("x","toggle")<CR>
nnoremap cc :call nerdcommenter#Comment('n',"toggle")<CR>

"Scroll
nnoremap <C-j> 10jzz0
nnoremap <C-k> 10kzz0

"Easy SO %
nnoremap vso :so ~/dotfiles/nvim/init.vim<cr><esc>

"moving bunch of lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-K> <esc>:m .-2<CR>==
inoremap <C-J> <esc>:m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

