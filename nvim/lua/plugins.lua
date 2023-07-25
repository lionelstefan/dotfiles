require("lazy").setup({
	{'folke/lazy.nvim'},
	{'luisiacc/gruvbox-baby'},
	{'ellisonleao/gruvbox.nvim', priority = 1000},
	{'nathom/filetype.nvim'},
	{'Vonr/align.nvim'},
	{
		'nvim-tree/nvim-web-devicons',
		config = function()
			require("nvim-web-devicons").setup {
				default = true
			}
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require("configs.lualine")
		end,
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},
	{
		'machakann/vim-sandwich',
	},
	{
		'tpope/vim-fugitive',
	},
	{'sindrets/diffview.nvim'},
	{
		'f-person/git-blame.nvim',
	},
	{
		'numToStr/Comment.nvim',
	},
-- TREESITTER
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require("configs.treesitter")
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
	},
	{
		"RRethy/nvim-treesitter-endwise",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"nvim-treesitter/nvim-treesitter-context"
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		'windwp/nvim-autopairs',
		config = function()
			require("nvim-autopairs").setup{
				check_ts = true
			}
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
		config = function()
		   require("configs.telescope")
		end,
		cmd = { "Telescope" },
	},
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",
	"nvim-telescope/telescope-project.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	{
		'lukas-reineke/indent-blankline.nvim',
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
	},
	{
		'akinsho/bufferline.nvim',
		config = function()
		   require("configs.bufferline")
		end,
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
		   require("configs.lsp")
		end
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("configs.cmp")
		end,
	},
-- LSP & CMP
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	"saadparwaiz1/cmp_luasnip",
	"onsails/lspkind.nvim",
	"RRethy/vim-illuminate",
	{
		'Pocco81/auto-save.nvim',
		config = function()
			require("auto-save").setup {}
		end,
	{
		'karb94/neoscroll.nvim', 
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		}
	}
}
}, {
	performance = {
		cache = {
			enabled = true
		},
		rpt = {
			disabled_plugins = {
				"netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "gzip",
                "zip",
                "zipPlugin",
                "tar",
                "tarPlugin",
                "getscript",
                "getscriptPlugin",
                "vimball",
                "vimballPlugin",
                "2html_plugin",
                "logipat",
                "rrhelper",
                "spellfile_plugin",
                "matchit",
			}
		}
	}
})
