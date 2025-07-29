require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  cmdline = {
    enabled = true,       -- enables the Noice cmdline UI
    view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    opts = {
      border = {
        text = {
          top = "",
        },
      },
    }, -- global options for the cmdline. See section on views
    format = {
      cmdline = { pattern = "^:", icon = ">", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = "/ ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
      input = {}, -- Used by input()
    },
  },
  popupmenu = {
    enabled = true, -- enables the Noice popupmenu UI
    backend = "nui", -- backend to use to show regular cmdline completions
    kind_icons = {}, -- set to `false` to disable icons
  },
  views = {
    cmdline_popup = {
      size = {
        width = 60,
        height = "auto",
      },
      win_options = {
        winblend = 60,
        winhighlight = {
          Normal = "NormalFloat",
          FloatBorder = "FloatBorder",
        },
        winbar = "",
        cursorline = true,
      },
    },
  },
})
