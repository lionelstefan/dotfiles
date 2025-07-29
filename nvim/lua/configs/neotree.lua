require("neo-tree").setup({
  hide_root_node = true,
  popup_border_style = "solid",
  enable_git_status = true,
  enable_diagnostics = false,
  enable_cursor_hijack = true,
  window = {
    auto_expand_width = true,
    popup = {
      title = function()
        return ""
      end,
    },
  },
  event_handlers = {
    {
      event = "neo_tree_popup_buffer_enter",
      handler = function()
        vim.cmd("highlight! Cursor blend=100")
      end,
    },
    {
      event = "neo_tree_popup_buffer_leave",
      handler = function()
        vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
      end,
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
    },
    icon = function(config, node)
      local highlights = require("neo-tree.ui.highlights")
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
  default_component_configs = {
    indent = {
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
    },
    window = {
      width = 60,
    },
  },
})
