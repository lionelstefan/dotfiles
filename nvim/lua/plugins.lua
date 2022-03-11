return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'ryanoasis/vim-devicons'
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	use 'StanAngeloff/php.vim'
	use 'jiangmiao/auto-pairs'
	use {'nvim-treesitter/nvim-treesitter', opt = true}
	use 'preservim/nerdcommenter'
	use 'sheerun/vim-polyglot'
	use 'ludovicchabant/vim-gutentags'
	use 'tpope/vim-fugitive'
	use 'p00f/nvim-ts-rainbow'
	use 'windwp/nvim-ts-autotag'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-project.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'morhetz/gruvbox'
	use {'lewis6991/gitsigns.nvim', 
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require("gitsigns").setup()
		end
	}
	use 'kyazdani42/nvim-web-devicons'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'
end)

