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
    event = { "BufReadPre" },
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
        event_handlers = {
          {
            event = "neo_tree_buffer_enter",
            handler = function()
              vim.cmd("highlight! Cursor blend=100")
            end,
          },
          {
            event = "neo_tree_buffer_leave",
            handler = function()
              vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
            end,
          },
        },
        enable_diagnostics = false,
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
          },
          icon = function(config, node, state)
            local icon = config.default or " "
            local padding = config.padding or " "
            local highlight = config.highlight or highlights.FILE_ICON

            if node.type == "directory" then
              highlight = highlights.DIRECTORY_ICON
              if node:is_expanded() then
                icon = config.folder_open or "-"
              else
                icon = config.folder_closed or "+"
              end
            elseif node.type == "file" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              if success then
                local devicon, hl = web_devicons.get_icon(node.name, node.ext)
                icon = devicon or icon
                highlight = hl or highlight
              end
            end

            return {
              text = icon .. padding,
              highlight = highlight,
            }
          end,
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
    "saghen/blink.cmp",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",
    dependencies = {
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
    opts = require("configs.blinkcmp").opts,
  },
  {
    "pmizio/typescript-tools.nvim",
    event = "LspAttach",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
        lazy = true,
      },
      {
        "saghen/blink.cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        lazy = true,
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
    "onsails/lspkind.nvim",
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
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
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
    event = { "BufReadPre" },
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre" },
    lazy = true,
    build = ":TSUpdate",
    config = function()
      require("configs.treesitter")
    end,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    event = { "BufReadPre" },
    lazy = true,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPre" },
    lazy = true,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre" },
    lazy = true,
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
        max_lines = 5,
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
    event = { "BufReadPre" },
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
    event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
    lazy = true,
  },

  -- LSP & CMP
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true,
        condition = function(buf)
          -- Don't autosave if buffer is unnamed or not modifiable
          local name = vim.api.nvim_buf_get_name(buf)
          local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
          return name ~= "" and buftype == ""
        end,
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
          timeout = 200,
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
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
        lazy = true,
      },
    },
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
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
    config = function()
      require("configs.lsp")
    end,
  },
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
    lazy = true,
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
    event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
    lazy = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
        event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
      },
      {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" }, -- only load on buffer read
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
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
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
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
    event = { "BufReadPre" },
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
    event = "VeryLazy",
    config = function()
      require("tiny-devicons-auto-colors").setup()
    end,
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
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
    event = "LspAttach",
    opts = {},
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,  -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "nonerdfont",
      })
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
  {
    "b0o/schemastore.nvim",
  },
  {
    "xzbdmw/colorful-menu.nvim",
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
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
    'mikew/nvim-drawer',
    opts = {},
    config = function(_, opts)
      local drawer = require('nvim-drawer')
      drawer.setup(opts)
      require("configs.drawer")
    end
  }
}

for _, colorscheme in ipairs(colorschemes) do
  table.insert(M, colorscheme)
end

for _, plugin in ipairs(plugins) do
  table.insert(M, plugin)
end

return M
