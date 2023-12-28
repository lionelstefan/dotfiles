require("lazy").setup({
	{
		"sainnhe/edge",
		lazy = true,
	},
	{
		"tanvirtin/monokai.nvim",
		lazy = true,
	},
	{
		"akinsho/horizon.nvim",
		version = "*",
		lazy = true,
	},
	{
		"kartikp10/noctis.nvim",
		lazy = true,
		dependencies = {
			"rktjmp/lush.nvim",
		},
	},
	{
		"srcery-colors/srcery-vim",
		lazy = true,
	},
	{
		"rose-pine/neovim",
		lazy = true,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
	},
	{
		"bluz71/vim-moonfly-colors",
		lazy = true,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	{
		"vuki656/package-info.nvim",
		config = function()
			require("package-info").setup()
		end,
	},
	{
		"b0o/incline.nvim",
		config = function()
			require("incline").setup()
		end,
	},
	{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup {
				filetypes = { "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "blade" }
			}
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("configs.null-ls")
		end
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("nvim-navic").setup({
				lsp = {
					auto_attach = true,
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},
	{
		"codota/tabnine-nvim",
		build = "./dl_binaries.sh",
		config = function()
			require("tabnine").setup({
				disable_auto_comment = true,
				accept_keymap = "<Tab>",
				dismiss_keymap = "<C-]>",
				debounce_ms = 800,
				suggestion_color = { gui = "#808080", cterm = 244 },
				exclude_filetypes = { "TelescopePrompt", "neo-tree" },
				log_file_path = nil, -- absolute path to Tabnine log file
			})
		end,
	},
	{
		"echasnovski/mini.bufremove",
		version = "*",
		config = function()
			require("mini.bufremove").setup()
		end,
	},
	{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
      	enable_diagnostics = false,
      	filesystem = {
      		filtered_items = {
      			visible = true,
      			hide_dotfiles = false,
      			hide_gitignored = false,
      			hide_hidden = false
					}
				}
			})
    end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({
				buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
					"neo-tree",
					"help",
					"nofile",
					"terminal",
					"prompt",
					"telescope",
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		keys = {
			{
				"kf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		config = function()
			require("configs.conform")
		end,
	},
	{
		"EmranMR/tree-sitter-blade",
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				timeout = 3000,
				render = "minimal",
				fps = 60,
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"Vonr/align.nvim",
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("configs.lualine")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "󰍵" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "│" },
				},
			})
		end,
	},
	{
		"machakann/vim-sandwich",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			require("rainbow-delimiters.setup").setup({
				strategy = {
					[""] = require("rainbow-delimiters").strategy["global"],
					vim = require("rainbow-delimiters").strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	-- TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	},
	{
		"RRethy/nvim-treesitter-endwise",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "neo-tree" },
				enable_check_bracket_line = false,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		config = function()
			require("configs.telescope")
		end,
		cmd = { "Telescope" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope-project.nvim",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("configs.ibl")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("configs.bufferline")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lsp")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		config = function()
			require("configs.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
	},
	-- LSP & CMP
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				enabled = true,
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"yamatsum/nvim-cursorline",
		config = function()
			require("nvim-cursorline").setup({
				cursorline = {
					enable = true,
					timeout = 1000,
					number = false,
				},
				cursorword = {
					enable = true,
					min_length = 3,
					hl = { underline = true },
				},
			})
		end,
	},
	{
		"folke/neodev.nvim",
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("ufo").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
}, {
	performance = {
		cache = {
			enabled = true,
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
				"syntax",
			},
		},
	},
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
