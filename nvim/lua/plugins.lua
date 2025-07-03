require("lazy").setup({
  {
    "samharju/synthweave.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "0xstepit/flow.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
  },
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
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        undercurl = false,
        underline = false,
        italic = {
          comments = true,
          strings = false,
          operators = false,
          folds = false,
        },
        bold = false,
        contrast = "hard",
      })
    end,
    lazy = true,
  },
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
    branch = "harpoon2",
    config = function()
      require("configs.harpoon")
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = true,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("hardtime").setup({
        disabled_filetypes = {
          "neo-tree",
          "lazy",
          "TelescopePrompt",
        },
      })
    end,
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("configs.incline")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "blade" },
    config = function()
      require("colorizer").setup({
        filetypes = { "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "blade" },
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
            hide_hidden = false,
          },
        },
        popup_border_style = "single",
        enable_git_status = true,
        default_component_configs = {
          window = {
            width = 60,
          },
        },
      })
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    event = "LspAttach",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      {
        "saghen/blink.cmp",
        lazy = false,
        priority = 1000,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "kf",
        function()
          require("conform").format({ async = true, lsp_format = "last" })
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
    event = "VeryLazy",
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
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { hl = 'GitSignsAdd', text = "│" },
          change = { hl = 'GitSignsChange', text = "│" },
          delete = { hl = 'GitSignsDelete', text = "󰍵" },
          topdelete = { hl = 'GitSignsDelete', text = "‾" },
          changedelete = { hl = 'GitSignsChange', text = "~" },
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
          virt_text_pos = 'right_align',
          delay = 300,
          virt_text_priority = 100,
        },
      })
    end,
  },
  {
    "machakann/vim-sandwich",
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
    "nvim-treesitter/playground",
  },
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
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        disable_filetype = { "TelescopePrompt", "neo-tree" },
        enable_check_bracket_line = false,
        ts_config = {
          lua = { "string" },            -- don't add pairs in lua string treesitter nodes
          javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        },
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
      "Snikimonkd/telescope-git-conflicts.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-frecency.nvim",
    },
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
  },
  {
    "saghen/blink.compat",
    lazy = true,
  },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    build = "cargo build --release",
    lazy = true,
    opts = require("configs.blinkcmp").opts,
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
      require("neoscroll").setup({})
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
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      -- options
    },
  },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
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
  -- 	event = "VeryLazy",
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
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },
  {
    "danymat/neogen",
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
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("configs.lsp")
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "fei6409/log-highlight.nvim",
    lazy = true,
    event = "VeryLazy",
    ft = { "log" },
    config = function()
      require("log-highlight").setup({})
    end,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "mxsdev/nvim-dap-vscode-js",
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
    "folke/lazydev.nvim",
    lazy = true,
    event = "VeryLazy",
    ft = { "lua" },
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },
  {
    "MTDL9/vim-log-highlighting",
    lazy = true,
    event = "VeryLazy",
    ft = { "log" },
  },
  {
    "olimorris/persisted.nvim",
    lazy = false,
    event = "BufReadPre",
    opts = {
      autostart = true,
      autoload = true,
      use_git_branch = true,
    },
  },
  -- Highlight URLs inside vim
  {
    "itchyny/vim-highlighturl",
    lazy = true,
    event = "VeryLazy",
  },
  {
    "jdhao/whitespace.nvim",
    event = { "InsertEnter" },
    lazy = true,
  },
  {
    "justinsgithub/wezterm-types",
    lazy = true,
    event = "VeryLazy",
  },
  {
    "LunarVim/bigfile.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("bigfile").setup({
        filesize = 2,  -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
        features = {   -- features to disable
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
  --   event = "VeryLazy",
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
    "dmmulroy/ts-error-translator.nvim",
    config = true,
  },
  {
    "mvllow/modes.nvim",
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
    "nvim-pack/nvim-spectre",
    config = function()
      require('spectre').setup()
    end
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10,
    opts = {
      overwrite = {
        undo = {
          enabled = true
        }
      }
    },
  }
}, {
  debug = false,
  defaults = { lazy = false },
  install = {
    colorscheme = {
      "gruvbox",
    }
  },
  concurrency = 10,
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
