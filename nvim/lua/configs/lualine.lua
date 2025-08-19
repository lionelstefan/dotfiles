--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

require("lualine").setup {
  options = {
    icons_enabled        = true,
    theme                = 'gruvbox',
    disabled_filetypes   = {
      statusline = { "neo-tree", "codecompanion" },
      winbar = { "neo-tree", "codecompanion" },
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
    lualine_a = {
      {
        'mode',
        icons_enabled = true,
      }
    },
    lualine_b = {
      {
        'branch',
        fmt = function(str)
          return str:sub(1, 20)
        end
      },
      {
        'diff'
      },
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
    lualine_x = {
      { 'searchcount' },
      { 'encoding' },
      { 'copilot' }
    },
    lualine_y = { 'lsp_status' },
    lualine_z = { 'location' }
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
