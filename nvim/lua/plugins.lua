return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'nathom/filetype.nvim'
	use 'lewis6991/impatient.nvim'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'ryanoasis/vim-devicons'
	use 'kyazdani42/nvim-web-devicons'
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}
	use 'StanAngeloff/php.vim'
	use 'jiangmiao/auto-pairs'
	use 'nvim-treesitter/nvim-treesitter'
	use 'JoosepAlviste/nvim-ts-context-commentstring'
	use 'RRethy/nvim-treesitter-endwise'
	use 'machakann/vim-sandwich'
	use 'sheerun/vim-polyglot'
	use 'ludovicchabant/vim-gutentags'
	use 'tpope/vim-fugitive'
	use 'sindrets/diffview.nvim'
	use 'f-person/git-blame.nvim'
	use {
		'numToStr/Comment.nvim',
		config = function()
			require("Comment").setup()
		end
	}
	use 'p00f/nvim-ts-rainbow'
	use 'windwp/nvim-ts-autotag'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-project.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	-- use 'lifepillar/vim-gruvbox8'
	use 'ellisonleao/gruvbox.nvim'
	use 'akinsho/bufferline.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'
	use {
		'rmagatti/auto-session',
		config = function()
			require('auto-session').setup {
			log_level = 'info',
			}
		end
	}
	use {'karb94/neoscroll.nvim', 
		config = function()
			require("neoscroll").setup()
		end
	}
	use 'RRethy/vim-illuminate'
end)

