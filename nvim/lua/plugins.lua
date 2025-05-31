require("lazy").setup({
  {
    "samharju/synthweave.nvim",
  },
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
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
    "m-demare/hlargs.nvim",
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
      require("incline").setup()
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
    config = function()
      require("colorizer").setup({
        filetypes = { "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "blade" },
      })
    end,
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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      {
        "saghen/blink.cmp",
        -- Ensure blink.cmp is loaded before typescript-tools
        lazy = false,
        priority = 1000,
      }
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
        timeout = 600,
        render = "wrapped-compact",
        stages = "fade",
        fps = 60,
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
          java = false,                  -- don't check treesitter on java
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
    build = "make",
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
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
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    version = "*",
    dependencies = {
      {
        "saghen/blink.compat",
        opts = { impersonate_nvim_cmp = true },
      },
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

    build = 'cargo build --release',

    opts = {
      keymap = {
        preset = 'super-tab',
        ["<S-k>"] = { "scroll_documentation_up", "fallback" },
        ["<S-j>"] = { "scroll_documentation_down", "fallback" }
      },

      snippets = {
        preset = 'luasnip',
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      },

      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
        },
      },

      completion = {
        trigger = {
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = { "'", '"', '(', '{' },
        },
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            treesitter = {},
          },
        },

        accept = {
          auto_brackets = { enabled = false },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          treesitter_highlighting = true,
        },

        ghost_text = {
          enabled = true,
        },

      },

      signature = {
        enabled = true,
      },
    },

    opts_extend = { "sources.default" },

    appearance = {
      kind_icons = {
        Copilot = "",
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',

        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',

        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',

        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',

        Keyword = '󰻾',
        Constant = '󰏿',

        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },

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
  {
    "echasnovski/mini.ai",
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
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
      local mason = require("mason")

      local mason_tool_installer = require("mason-tool-installer")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "bashls",
          "dockerls",
          "docker_compose_language_service",
          "lua_ls",
          "dotls",
          "html",
          "eslint",
          "ts_ls",
          "marksman",
          "phpactor",
          "ruff",
          "yamlls",
          "jsonls",
          "vls",
        },
      })
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
    "f-person/git-blame.nvim",
    config = function()
      require("gitblame").setup()
    end,
  },
  {
    "fei6409/log-highlight.nvim",
    config = function()
      require("log-highlight").setup({})
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "mxsdev/nvim-dap-vscode-js",
      {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    config = function()
      require("configs.dap")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
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
  },
  {
    "olimorris/persisted.nvim",
    lazy = false,
    config = function()
      require("persisted").setup({
        autoload = true,
      })
    end,
  },
  -- Highlight URLs inside vim
  {
    "itchyny/vim-highlighturl",
    event = "VeryLazy",
  },
  {
    "jdhao/whitespace.nvim",
    event = "VeryLazy",
  },
  {
    "justinsgithub/wezterm-types",
    lazy = true,
  },
  {
    "LunarVim/bigfile.nvim",
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
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- never set this value to "*"! never!
    opts = {
      provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "muniftanjim/nui.nvim",
      --- the below dependencies are optional,
      "echasnovski/mini.pick",      -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",           -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- make sure to set this up properly if you have lazy=true
        "meanderingprogrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "avante" },
        },
        ft = { "markdown", "avante" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        svelte = { "eslint" },
        python = { "pylint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },

  {
    "dmmulroy/ts-error-translator.nvim",
    config = true
  },
  {
    "mvllow/modes.nvim",
    config = function()
      require('modes').setup({
        colors = {
          visual = "#bababa",
        },
        line_opacity = 0.3,
      })
    end
  },

  {
    "pmizio/typescript-tools.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      {
        "saghen/blink.cmp",
        lazy = false,
        priority = 1000,
      }
    },
  },
}, {
  checker = {
    enabled = true,  -- enables the update checker
    concurrency = 8, -- limit the number of concurrent update checks
    frequency = 86400, -- check for updates every 24 hour (in seconds)
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
