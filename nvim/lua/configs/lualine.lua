require("lualine").setup {
  options = {
    icons_enabled        = true,
    theme                = 'auto',
    disabled_filetypes   = {
      statusline = { "neo-tree" },
      winbar = {},
    },
    component_separators = {
      left = '',
      right = ''
    },
    section_separators   = {
      left = '',
      right = ''
    }
  },
  sections = {
    lualine_b = {
      'branch', 'diff',
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
        shorting_target = 40,
        symbols = {
          modified = '[M]',
          readonly = '[R]',
          unnamed = '[NONAME]'
        }
      }
    },
  },
  opts = function(_, opts)
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    })
    table.insert(opts.sections.lualine_c, {
      symbols.get,
      cond = symbols.has,
    })
  end,
}
