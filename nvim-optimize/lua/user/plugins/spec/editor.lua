-- Editor enhancements
-- Treesitter, pairs, comments, motions, and text objects

return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Treesitter context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = { max_lines = 3 },
  },

  -- Auto close tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- Better endwise
  {
    "RRethy/nvim-treesitter-endwise",
    event = "InsertEnter",
  },

  -- Context commentstring
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
    opts = {
      enable_autocmd = false,
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })

      -- Integration with cmp/blink
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local ok, cmp = pcall(require, "cmp")
      if ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    opts = {},
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Better text objects
  {
    "echasnovski/mini.ai",
    event = "BufReadPost",
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
        },
      }
    end,
  },

  -- Highlight function arguments
  {
    "m-demare/hlargs.nvim",
    event = "BufReadPost",
    opts = {},
  },

  -- Floating statuslines
  {
    "b0o/incline.nvim",
    event = "BufReadPost",
    config = function()
      require("incline").setup({
        debounce_threshold = {
          falling = 50,
          rising = 10,
        },
      })
    end,
  },

  -- Search result highlighting
  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      {
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        desc = "Next search result + hlslens",
      },
      {
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        desc = "Prev search result + hlslens",
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

  -- Jump navigation
  {
    "echasnovski/mini.jump",
    event = "BufReadPost",
    opts = {},
  },

  -- Buffer deletion
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
    },
    config = function()
      require("mini.bufremove").setup({
        silent = true,
      })
    end,
  },

  -- Text alignment
  {
    "Vonr/align.nvim",
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

  -- Surround alternative
  {
    "machakann/vim-sandwich",
    event = "BufReadPost",
  },

  -- Colored brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
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

  -- Automatic saving
  {
    "Pocco81/auto-save.nvim",
    event = "BufReadPost",
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

  -- Cursor highlighting
  {
    "yamatsum/nvim-cursorline",
    event = "BufReadPost",
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

  -- Better escape sequences
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- Whitespace management
  {
    "jdhao/whitespace.nvim",
    event = "InsertEnter",
    config = function()
      require("whitespace-nvim").setup({
        ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard", "neo-tree" },
        ignore_terminal = true,
        return_cursor = true,
      })
    end,
  },

  -- TypeScript error translation
  {
    "dmmulroy/ts-error-translator.nvim",
    event = "LspAttach",
    ft = { "typescript", "typescriptreact" },
    opts = {},
  },

  -- Undo highlighting
  {
    "rachartier/tiny-glimmer.nvim",
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

  -- Code actions
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
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
    opts = {},
  },

  -- Lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        "wezterm-types",
      },
    },
  },

  -- Automatic indentation detection
  {
    "nmac427/guess-indent.nvim",
    event = "BufReadPost",
    config = function()
      require("guess-indent").setup({})
    end,
  },

  -- Smart column display
  {
    "m4xshen/smartcolumn.nvim",
    event = "BufReadPost",
    config = function()
      require("smartcolumn").setup({
        colorcolumn = "120",
        disabled_filetypes = {
          "text",
          "markdown",
          "mason",
          "checkhealth",
          "lspinfo",
          "neo-tree",
          "lazy",
          "TelescopePrompt",
          "help",
          "dashboard",
          "Avante",
          "AvanteChat",
          "AvanteSelectedFiles",
          "AvanteInput",
          "avante",
          "AvanteTodos",
        },
      })
    end,
  },

  -- OpenCode integration
  {
    "NickvanDyke/opencode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {},
    keys = {
      { '<leader>oc', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
      { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
      { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
      { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
      { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
      { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', },
      { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    },
  },
}