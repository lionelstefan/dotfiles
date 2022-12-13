vim.cmd [[packadd packer.nvim]]

local function plugins(use)
	use {'wbthomason/packer.nvim'}
	use {'luisiacc/gruvbox-baby'}
	use {'nathom/filetype.nvim'}
	use { "nvim-lua/plenary.nvim", module = "plenary" }
	use {
		'kyazdani42/nvim-web-devicons',
		module = 'nvim-web-devicons',
		config = function()
			require("nvim-web-devicons").setup {
				default = true
			}
		end
	}
	use {
		'nvim-lualine/lualine.nvim',
		event = "VimEnter",
		after = "nvim-treesitter",
		config = function()
			require("plugins.lualine").setup()
		end,
		wants = 'nvim-web-devicons',
		requires = {
			"kyazdani42/nvim-web-devicons"
		}
	}
	use {
		'StanAngeloff/php.vim',
		ft = {"php"}
	}
	use {
		'machakann/vim-sandwich',
		event = "InsertEnter"
	}
	use {
		'tpope/vim-fugitive',
		event="BufReadPre"
	}
	use {'sindrets/diffview.nvim'}
	use {
		'f-person/git-blame.nvim',
		event="BufRead"
	}
	use {
		'numToStr/Comment.nvim',
		event = "BufRead",
		config = function()
			require("Comment").setup()
		end,
		event="BufRead"
	}
-- TREESITTER
	use {
		'nvim-treesitter/nvim-treesitter'
	}
	use {
		"p00f/nvim-ts-rainbow"
	}
	use {
		"RRethy/nvim-treesitter-endwise"
	}
	use {
		"JoosepAlviste/nvim-ts-context-commentstring"
	}
	use {
		"nvim-treesitter/nvim-treesitter-context"
	}
	use {
		"windwp/nvim-ts-autotag"
	}
	use {
		'windwp/nvim-autopairs',
		event = "BufWinEnter",
		requires = {
			"nvim-treesitter"
		},
		module = {
			'nvim-autopairs.completion.cmp',
			'nvim-autopairs'
		}
	}
	use {
		'nvim-telescope/telescope.nvim',
		event = "BufWinEnter",
		config = function()
			require("plugins.telescope").setup()
		end,
		cmd = { "Telescope" },
		module = {
			"telescope",
			"telescope.builtin"
		},
		wants = {
			"plenary.nvim",
			"popup.nvim",
			"telescope-project.nvim",
			"telescope-file-browser.nvim"
		},
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-file-browser.nvim"
		}
	}
	use {
		'lukas-reineke/indent-blankline.nvim',
		event = "BufRead",
		requires = "nvim-treesitter",
		config = function()
			vim.cmd[[highlight IndentBlankLineIndent1 guifg=#666666 gui=nocombine]]
			require("indent_blankline").setup {
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
				char_highlight_list = {
					"IndentBlankLineIndent1"
				}
			}
		end
	}
	use {
		'akinsho/bufferline.nvim',
		event="VimEnter",
		wants = 'nvim-web-devicons',
		requires = {
			"kyazdani42/nvim-web-devicons"
		},
		config = function()
		   require("plugins.bufferline").setup()
		end,
	}
	use "hrsh7th/nvim-cmp"
	use {
			"hrsh7th/cmp-buffer",
			event = "BufWinEnter",
			config = function()
				require("plugins.cmp").setup()
			end,
			wants = {
				"LuaSnip",
				"cmp_luasnip",
				"cmp-path",
				"cmp-cmdline",
				"cmp-nvim-lsp",
				"friendly-snippets",
			},
			requires = {
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp",
				"L3MON4D3/LuaSnip",
				"rafamadriz/friendly-snippets",
				"saadparwaiz1/cmp_luasnip"
			}
	}
	use {
		'neovim/nvim-lspconfig',
		event = "BufWinEnter",
		config = function()
			require("plugins.lsp")
		end,
		wants = {
			"nvim-cmp",
			"cmp-nvim-lsp",
			"vim-illuminate"
		},
		requires = {
			"hrsh7th/nvim-cmp",
			"RRethy/vim-illuminate",
			"hrsh7th/cmp-nvim-lsp",
		}
	}
	use {
		'rmagatti/auto-session',
		event="VimEnter",
		config = function()
			require('auto-session').setup {
				log_level = 'info',
			}
		end,
	}
	use {
		'karb94/neoscroll.nvim', 
		event="VimEnter",
		config = function()
			require("neoscroll").setup()
		end,
	}
	use {
		'Pocco81/auto-save.nvim',
		event="VimEnter",
		config = function()
			require("auto-save").setup {}
		end,
	}
end

local conf = {
	profile = {
		enable = true,
		treshold = 0
	},

	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end
	}
}

local packer = require "packer"

packer.init(conf)

return packer.startup(plugins)
