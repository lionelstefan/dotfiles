vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  nested = true,
  callback = function()
    vim.cmd("colorscheme gruvbox")
    vim.opt.fillchars = { eob = " ", fold = " " }
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  pattern = "*",
  nested = true,
  callback = function()
    vim.cmd("colorscheme gruvbox")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "vue", "php" },
  callback = function(args)
    local two_space = { javascript = true, typescript = true, vue = true }
    local four_space = { php = true }

    if two_space[args.match] then
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.shiftwidth = 2
    elseif four_space[args.match] then
      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.shiftwidth = 4
    end

    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd({
  "BufWritePost",
}, {
  callback = function(args)
    pcall(require("conform").format, {
      bufnr = args.buf,
      async = false,
      timeout_ms = 500,
      formatters = { "trim_whitespace", "trim_newlines" },
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function(args)
    local client = nil
    local bufnr = args.buf
    for _, c in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if c.name == "tsserver" then
        client = c
        break
      end
    end

    if client then
      -- add missing imports
      vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
        command = "_typescript.addMissingImports",
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
      }, function(err, result, ctx, config)
          if err then
            vim.notify("Error running addMissingImports: " .. err.message, vim.log.levels.ERROR)
          end
        end)

      local uri = vim.uri_from_bufnr(bufnr)

      -- organize imports
      vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
        command = "_typescript.organizeImports",
        arguments = { uri },
      }, function(err)
          if err then
            vim.notify("Organize Imports failed: " .. err.message, vim.log.levels.ERROR)
          end
        end)

      -- remove unused
      vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
        command = "_typescript.removeUnused",
        arguments = { uri },
      }, function(err)
          if err then
            vim.notify("Remove Unused failed: " .. err.message, vim.log.levels.ERROR)
          end
        end)
    end

    require("conform").format({ bufnr = bufnr })
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
    local colors = {
      bg = "#282828",
      fg = "#fbf1c7",
      yellow = "#f9bd2a",
      gray = "#7c6f64",
      dark_gray = "#3c3836",
      green = "#a9b665",
      orange = "#f28534",
      blue = "#7daea3",
      purple = "#d3869b",
      scrollbar = "#665c54",
    }

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.bg, fg = colors.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = colors.bg, fg = colors.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = colors.gray, bg = colors.bg })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = colors.dark_gray, fg = colors.yellow, bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { bg = colors.scrollbar })
    vim.api.nvim_set_hl(0, "BlinkCmpScrollBarGutter", { bg = colors.bg })

    vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = colors.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { fg = colors.gray, strikethrough = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = colors.yellow, bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = colors.gray })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = colors.gray })

    vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = colors.green })
    vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = colors.green })
    vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = colors.green })
    vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = colors.purple })
    vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = colors.orange })
    vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = colors.orange })
    vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = colors.fg })

    vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = colors.gray })
    vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = colors.gray, italic = true })

    vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = colors.bg, fg = colors.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = colors.gray, bg = colors.bg })
    vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { fg = colors.gray })
    vim.api.nvim_set_hl(0, "BlinkCmpDocCursorLine", { bg = colors.dark_gray })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = colors.bg, fg = colors.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = colors.gray, bg = colors.bg })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = colors.yellow, underline = true })

    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", {
      fg = "gray",
    })

    -- FIDGET
    vim.api.nvim_set_hl(0, "FidgetDoneStyle", { fg = "#98C379" })

    vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#e45555" })
    vim.api.nvim_set_hl(0, "DapBreakpointConditionColor", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "DapBreakpointRejectedColor", { fg = "#BE5046" })
    vim.api.nvim_set_hl(0, "DapLogPointColor", { fg = "#56B6C2" })
    vim.api.nvim_set_hl(0, "DapStoppedColor", { fg = "#98C379", bold = true })
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = colors.bg })

    local signs = {
      "DiagnosticSignWarn",
      "DiagnosticSignError",
      "DiagnosticSignHint",
      "DiagnosticSignInfo",
      "DiagnosticSignOk",
    }

    for _, group in ipairs(signs) do
      local current = vim.api.nvim_get_hl(0, { name = group, link = false })
      vim.api.nvim_set_hl(0, group, {
        fg = current.fg,
        bg = "none",
        bold = current.bold,
        italic = current.italic,
        underline = current.underline,
        reverse = current.reverse,
        standout = current.standout,
        strikethrough = current.strikethrough,
        nocombine = current.nocombine,
      })
    end

    -- GIT CONFLICT HL
    vim.api.nvim_set_hl(0, "DiffAdd", {
      bg = colors.blue,
      fg = colors.fg,
    })

    vim.api.nvim_set_hl(0, "DiffText", {
      bg = colors.orange,
      fg = colors.fg,
    })
  end,
})

vim.cmd([[
  highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
  highlight! link NeoTreeDirectoryName NvimTreeFolderName
  highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
  highlight! link NeoTreeRootName NvimTreeRootFolder
  highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
  highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
]])

vim.api.nvim_create_user_command("CloseFindReplace", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match("Find and Replace") then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, {})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
