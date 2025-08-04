local M = {}

local colorschemes = require("plugins.colorscheme")

local plugins = {
	{
		"m-demare/hlargs.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("hlargs").setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		lazy = true,
		keys = {
			{
				"<leader>td",
				"<Cmd>Trouble diagnostics toggle<CR>",
				desc = "Trouble diagnostics",
			},
		},
		opts = {
			win = {
				size = {
					height = 5,
				},
			},
		},
		cmd = "Trouble",
	},
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		branch = "harpoon2",
		keys = {
			{
				"<leader>dh",
				function()
					require("harpoon"):list():clear()
				end,
				desc = "Harpoon",
			},
		},
		config = function()
			require("configs.harpoon")
		end,
	},
	-- {
	-- 	"m4xshen/hardtime.nvim",
	--    lazy = true,
	--    event = "VeryLazy",
	-- 	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	-- 	opts = {},
	-- 	config = function()
	-- 		require("hardtime").setup({
	-- 			disabled_filetypes = {
	-- 				"neo-tree",
	-- 				"lazy",
	-- 				"TelescopePrompt",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"b0o/incline.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("configs.incline")
		end,
	},
	{
		"kylechui/nvim-surround",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		ft = { "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "blade", "lua" },
		config = function()
			require("colorizer").setup({
				filetypes = {
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"html",
					"blade",
					"lua",
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		lazy = true,
		keys = {
			{
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				desc = "Next search result + hlslens",
				expr = false,
			},
			{
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				desc = "Prev search result + hlslens",
				expr = false,
			},
			{ "*", [[*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search * with hlslens" },
			{ "#", [[#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search # with hlslens" },
			{ "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search g* with hlslens" },
			{ "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search g# with hlslens" },
		},
		config = function()
			require("hlslens").setup({
				calm_down = true,
				nearest_only = true,
			})
		end,
	},
	{
		"echasnovski/mini.jump",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"echasnovski/mini.bufremove",
		config = function()
			require("mini.bufremove").setup({
				silent = true,
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = true,
		keys = {
			{
				"<leader>b",
				"<cmd>Neotree float<cr>",
				desc = "Neotree open float",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("configs.neotree")
		end,
	},
	{
		"saghen/blink.cmp",
		lazy = true,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		build = "cargo build --release",
		opts = require("configs.blinkcmp").opts,
	},
	-- {
	--   "pmizio/typescript-tools.nvim",
	--   event = "LspAttach",
	--   ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--     {
	--       "neovim/nvim-lspconfig",
	--       event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
	--       lazy = true,
	--     },
	--     {
	--       "saghen/blink.cmp",
	--       event = { "InsertEnter", "CmdlineEnter" },
	--       lazy = true,
	--     },
	--   },
	--   config = function()
	--     local api = require("typescript-tools.api")
	--     require("typescript-tools").setup({
	--       settings = {
	--         tsserver_file_preferences = {
	--           importModuleSpecifierPreference = "non-relative",
	--         },
	--       },
	--     })
	--   end,
	-- },
	{
		"stevearc/conform.nvim",
		lazy = true,
		keys = {
			{
				"kf",
				function()
					require("conform").format({ async = true, timeout_ms = 500, lsp_format = "last" })
				end,
				mode = "n",
				desc = "Format file (Conform)",
			},
			{
				"kf",
				function()
					require("conform").format({ async = true, timeout_ms = 500, lsp_format = "last" })
				end,
				mode = "v",
				desc = "Format selection (Conform)",
			},
		},
		config = function()
			require("configs.conform")
		end,
	},
	{
		"EmranMR/tree-sitter-blade",
		lazy = true,
		event = "VeryLazy",
		ft = { "blade" },
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("notify").setup({
				timeout = 3000,
				render = "wrapped-compact",
				stages = "static",
				fps = 1,
			})

			vim.notify = require("notify")
		end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"Vonr/align.nvim",
		lazy = true,
		keys = {
			{
				"as",
				function()
					require("align").align_to_string(false, true, true)
				end,
				mode = "x",
				desc = "Align to string (left, with preview)",
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"onsails/lspkind.nvim",
		lazy = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("configs.lualine")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		lazy = true,
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { hl = "GitSignsAdd", text = "│" },
					change = { hl = "GitSignsChange", text = "│" },
					delete = { hl = "GitSignsDelete", text = "󰍵" },
					topdelete = { hl = "GitSignsDelete", text = "‾" },
					changedelete = { hl = "GitSignsChange", text = "~" },
					untracked = { text = "│" },
				},
				numhl = false,
				linehl = false,
				watch_gitdir = { interval = 1000 },
				sign_priority = 6,
				update_debounce = 200,
				status_formatter = nil,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "right_align",
					delay = 300,
					virt_text_priority = 100,
				},
			})
		end,
	},
	{
		"machakann/vim-sandwich",
		lazy = true,
		event = "BufReadPost",
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		event = "BufReadPost",
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
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	-- TREESITTER
	{
		"nvim-treesitter/playground",
		event = "VeryLazy",
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "InsertEnter" },
		lazy = true,
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		event = { "InsertEnter" },
		lazy = true,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufReadPre" },
		lazy = true,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("configs.autopairs")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("treesitter-context").setup({
				max_lines = 2,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("configs.telescope")
		end,
		keys = {
			{
				"fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Telescope buffers",
			},
			{
				"fp",
				function()
					require("telescope").extensions.project.project({})
				end,
				desc = "Telescope project",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"Snikimonkd/telescope-git-conflicts.nvim",
			{
				"nvim-telescope/telescope-project.nvim",
				lazy = true,
				event = "VeryLazy",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				cmd = "Telescope file_browser",
				lazy = true,
				event = "VeryLazy",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				lazy = true,
				event = "VeryLazy",
			},
			{
				"nvim-telescope/telescope-frecency.nvim",
				lazy = true,
				event = "VeryLazy",
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = { "VeryLazy" },
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
		"Pocco81/auto-save.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("auto-save").setup({
				enabled = true,
				condition = function(buf)
					if not vim.api.nvim_buf_is_valid(buf) then
						return false
					end

					local name = vim.api.nvim_buf_get_name(buf)
					local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
					return name ~= "" and buftype == ""
				end,
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		"yamatsum/nvim-cursorline",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("nvim-cursorline").setup({
				cursorline = {
					enable = true,
					timeout = 0,
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
		"j-hui/fidget.nvim",
		lazy = true,
		event = "LspAttach",
		version = "*",
		config = function()
			require("fidget").setup({
				progress = {
					display = {
						done_icon = " ",
						done_style = "FidgetDoneStyle",
						icon_style = "FidgetDoneStyle",
					},
				},
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		event = "VeryLazy",
		keys = {
			{
				"tt",
				"<cmd>ToggleTerm<cr>",
				desc = "Toggleterm",
			},
		},
		config = function()
			require("toggleterm").setup({
				auto_scroll = false,
				border = "curved",
				direction = "float",
			})
		end,
	},
	{
		"max397574/better-escape.nvim",
		lazy = true,
		config = function()
			require("better_escape").setup()
		end,
	},
	-- {
	-- 	"echasnovski/mini.ai",
	-- 	-- keys = {
	-- 	--   { "a", mode = { "x", "o" } },
	-- 	--   { "i", mode = { "x", "o" } },
	-- 	-- },
	-- 	event = "BufReadPost",
	-- 	opts = function()
	-- 		local ai = require("mini.ai")
	-- 		return {
	-- 			n_lines = 500,
	-- 			custom_textobjects = {
	-- 				o = ai.gen_spec.treesitter({
	-- 					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
	-- 					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
	-- 				}, {}),
	-- 				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
	-- 				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
	-- 				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
	-- 			},
	-- 		}
	-- 	end,
	-- 	config = function(_, opts)
	-- 		require("mini.ai").setup(opts)
	-- 	end,
	-- },
	{
		"zeioth/garbage-day.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			{
				"neovim/nvim-lspconfig",
			},
		},
	},
	{
		"danymat/neogen",
		lazy = true,
		event = "VeryLazy",
		cmd = {
			"Neogen",
		},
		config = function()
			require("neogen").setup({
				enabled = true,
				languages = {
					php = {
						template = {
							annotation_convention = "phpdoc",
						},
					},
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		lazy = true,
		cmd = {
			"Mason",
		},
		dependencies = {
			"mason-org/mason-registry",
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{
				"mason-org/mason.nvim",
			},
			{
				"neovim/nvim-lspconfig",
			},
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		event = "VeryLazy",
		keys = {
			{
				"lg",
				"<cmd>LazyGit<cr>",
				desc = "Lazygit",
			},
		},
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.g["lazygit_floating_window_scaling_factor"] = 1
		end,
	},
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		event = "LspAttach",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			{
				"microsoft/vscode-js-debug",
				build = function()
					local install_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"

					if not vim.fn.isdirectory(install_path .. "/out") then
						vim.cmd("echo 'Installing vscode-js-debug...'")
						vim.fn.system({
							"npm",
							"install",
							"--legacy-peer-deps",
						})

						vim.cmd("echo 'Building vsDebugServerBundle...'")
						vim.fn.system({ "npx", "gulp", "vsDebugServerBundle" })

						vim.cmd("echo 'Moving dist to out...'")
						vim.fn.system({ "mv", "dist", "out" })
					else
						vim.cmd("echo 'vscode-js-debug already built.'")
					end
				end,
			},
		},
		config = function()
			require("configs.dap")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("project_nvim").setup({})
		end,
	},
	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},
	{
		"olimorris/persisted.nvim",
		opts = {
			autostart = true,
			autoload = true,
			use_git_branch = true,
		},
	},
	{
		"itchyny/vim-highlighturl",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"jdhao/whitespace.nvim",
		ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard", "neo-tree" },
		ignore_terminal = true,
		return_cursor = true,
		event = { "InsertEnter" },
		lazy = true,
	},
	{
		"justinsgithub/wezterm-types",
		lazy = true,
		event = "VeryLazy",
		ft = "wezterm",
	},
	{
		"LunarVim/bigfile.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("bigfile").setup({
				filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
				pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
				features = { -- features to disable
					"indent_blankline",
					"illuminate",
					"lsp",
					"treesitter",
					"syntax",
					"matchparen",
					"vimopts",
					"filetype",
				},
			})
		end,
	},
	-- {
	--   {
	--     "CopilotC-Nvim/CopilotChat.nvim",
	--     dependencies = {
	--       { "github/copilot.vim" },                   -- or zbirenbaum/copilot.lua
	--       { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	--     },
	--     build = "make tiktoken",                      -- Only on MacOS or Linux
	--   },
	-- },
	-- {
	--   "yetone/avante.nvim",
	--   event = "BufReadPost",
	--   lazy = true,
	--   version = false, -- never set this value to "*"! never!
	--   opts = {
	--     provider = "claude",
	--     claude = {
	--       endpoint = "https://api.anthropic.com",
	--       model = "claude-3-5-sonnet-20241022",
	--       temperature = 0,
	--       max_tokens = 4096,
	--     },
	--   },
	--   build = "make",
	--   dependencies = {
	--     "nvim-treesitter/nvim-treesitter",
	--     "stevearc/dressing.nvim",
	--     "nvim-lua/plenary.nvim",
	--     "muniftanjim/nui.nvim",
	--     --- the below dependencies are optional,
	--     "echasnovski/mini.pick",      -- for file_selector provider mini.pick
	--     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
	--     "hrsh7th/nvim-cmp",           -- autocompletion for avante commands and mentions
	--     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	--     {
	--       -- make sure to set this up properly if you have lazy=true
	--       "meanderingprogrammer/render-markdown.nvim",
	--       opts = {
	--         file_types = { "markdown", "avante" },
	--       },
	--       ft = { "markdown", "avante" },
	--     },
	--   },
	-- },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		}, -- if you prefer nvim-web-devicons
		opts = {},
		filetypes = { "markdown" },
		config = function()
			require("render-markdown").setup({
				completions = {
					lsp = { enabled = true },
					blink = { enabled = true },
				},
			})
		end,
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		lazy = true,
		event = { "LspAttach" },
	},
	{
		"mvllow/modes.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("modes").setup({
				colors = {
					visual = "#bababa",
				},
				line_opacity = 0.3,
			})
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		lazy = true,
		event = "VeryLazy",
		keys = {
			{
				"<leader>sr",
				function()
					require("grug-far").open({ transient = true })
				end,
				desc = "Find and Replace in Project",
			},
			{
				"Q",
				function()
					local bufname = vim.api.nvim_buf_get_name(0)

					if bufname and bufname:find("Grug FAR") then
						local instance = require("grug-far").get_instance(0)
						if instance then
							instance:close()
						end
					end
				end,
				desc = "Close Find and Replace in Project",
			},
		},
		config = function()
			require("grug-far").setup({
				-- search the whole project (starting from cwd)
				search_path = require("lspconfig.util").root_pattern(".git")(vim.fn.expand("%:p")),

				-- options passed to ripgrep (rg)
				rg_opts = {
					"--hidden", -- include hidden files
					"--glob",
					"!.git/", -- exclude .git directory
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},

				-- options passed to replace
				sed_opts = {
					"-i",
					"",
				},

				-- whether to replace using sed or not (default: true)
				use_sed = true,
			})
		end,
	},
	{
		"rachartier/tiny-devicons-auto-colors.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("tiny-devicons-auto-colors").setup()
		end,
	},
	{
		"rachartier/tiny-glimmer.nvim",
		lazy = true,
		event = "InsertEnter",
		priority = 10,
		opts = {
			overwrite = {
				undo = {
					enabled = true,
				},
			},
		},
	},
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		lazy = true,
		event = "LspAttach",
		keys = {
			{
				"<leader>ca",
				function()
					require("tiny-code-action").code_action()
				end,
				mode = { "n", "x" },
				desc = "Code Action (tiny)",
				silent = true,
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		lazy = true,
		event = "LspAttach",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "nonerdfont",
			})
		end,
	},
	{
		"b0o/schemastore.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"xzbdmw/colorful-menu.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"folke/snacks.nvim",
		lazy = true,
		event = "InsertEnter",
		priority = 1000,
		opts = {
			bigfile = { enabled = false },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = false },
			notifier = { enabled = false },
			quickfile = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = {
				debounce = 10,
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("lint").linters_by_ft = {
				vue = { "oxlint" },
				javascript = { "oxlint" },
				typescript = { "oxlint" },
				javascriptreact = { "oxlint" },
				typescriptreact = { "oxlint" },
				json = { "jsonlint" },
				jsonc = { "jsonlint" },
			}
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup({
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
				default_mappings = {
					ours = "o",
					theirs = "t",
					none = "0",
					both = "b",
					next = "n",
					prev = "N",
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline",
			},
			messages = {
				enabled = true,
			},
			presets = {
				bottom_search = false,
				command_palette = false,
				long_message_to_split = true,
				lsp_doc_border = false,
			},
			lsp = {
				progress = {
					enabled = false,
				},
				hover = {
					enabled = true,
					view = "hover",
					opts = {
						border = {
							style = "none",
							padding = {
								top = 1,
								bottom = 1,
								left = 1,
								right = 1,
							},
						},
						win_options = {
							winhighlight = {
								Normal = "NormalFloat",
								FloatBorder = "FloatBorder",
							},
						},
						scrollbar = false,
					},
				},
				documentation = {
					view = "hover",
					opts = {
						border = {
							style = "none",
							padding = {
								top = 1,
								bottom = 1,
								left = 1,
								right = 1,
							},
						},
						win_options = {
							winhighlight = {
								Normal = "NormalFloat",
								FloatBorder = "FloatBorder",
							},
						},
					},
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
		},
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		config = function()
			require("pretty_hover").setup({
				border = "none",
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("configs.fzf")
		end,
		keys = {
			{
				"ff",
				function()
					require("fzf-lua").files({
						cwd = vim.loop.cwd(),
					})
				end,
				desc = "Fzf find files",
			},
			{
				"fg",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Fzf find files",
			},
		},
	},
	{
		"folke/lazydev.nvim",
		lazy = true,
		ft = "lua",
		opts = {
			library = {
				"lazy.nvim",
				"wezterm-types",
			},
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		config = function()
			require("CopilotChat").setup()
		end,
	},
	{ "typicode/bg.nvim", lazy = false },
}

for _, colorscheme in ipairs(colorschemes) do
	table.insert(M, colorscheme)
end

for _, plugin in ipairs(plugins) do
	table.insert(M, plugin)
end

return M
