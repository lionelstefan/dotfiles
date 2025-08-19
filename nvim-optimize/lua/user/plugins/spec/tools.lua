-- Development tools
-- Telescope, file navigation, search, and productivity tools

return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "Snikimonkd/telescope-git-conflicts.nvim",
      {
        "nvim-telescope/telescope-project.nvim",
        event = "VeryLazy",
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        cmd = "Telescope file_browser",
        event = "VeryLazy",
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        event = "VeryLazy",
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        event = "VeryLazy",
      },
    },
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
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<C-n>"] = "move_selection_next",
              ["<C-p>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
            n = {
              ["q"] = "close",
            },
          },
        },
      })
      
      -- Load extensions
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "project")
      pcall(require("telescope").load_extension, "file_browser")
      pcall(require("telescope").load_extension, "frecency")
      pcall(require("telescope").load_extension, "git_conflicts")
    end,
  },

  -- FZF Lua alternative
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "ff",
        function()
          require("fzf-lua").files({
            cwd = vim.uv.cwd(),
          })
        end,
        desc = "Fzf find files",
      },
      {
        "fg",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Fzf live grep",
      },
    },
    config = function()
      require("fzf-lua").setup({
        "telescope",
        winopts = {
          height = 0.85,
          width = 0.80,
          preview = {
            default = "bat",
          },
        },
      })
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>b",
        "<cmd>Neotree float<cr>",
        desc = "Neotree open float",
      },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = {
            ["<space>"] = "none",
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
        },
      })
    end,
  },

  -- Harpoon (quick file navigation)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>dh",
        function()
          require("harpoon"):list():clear()
        end,
        desc = "Harpoon clear list",
      },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },

  -- Search and replace
  {
    "MagicDuck/grug-far.nvim",
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
        search_path = require("lspconfig.util").root_pattern(".git")(vim.fn.expand("%:p")),
        rg_opts = {
          "--hidden",
          "--glob",
          "!.git/",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        sed_opts = {
          "-i",
          "",
        },
        use_sed = true,
      })
    end,
  },

  -- Documentation generator
  {
    "danymat/neogen",
    event = "VeryLazy",
    cmd = "Neogen",
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

  -- Treesitter playground
  {
    "nvim-treesitter/playground",
    event = "VeryLazy",
    cmd = "TSPlaygroundToggle",
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
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

  -- Session persistence
  {
    "olimorris/persisted.nvim",
    opts = {
      autostart = true,
      autoload = true,
      use_git_branch = true,
    },
  },

  -- LSP memory management
  {
    "zeioth/garbage-day.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({})
    end,
  },

  -- Lua types
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },

  -- Additional linting
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

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
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
      require("user.configs.dap")
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
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
      require("user.configs.conform")
    end,
  },
}