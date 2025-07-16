vim.cmd([[
	autocmd VimEnter * ++nested colorscheme gruvbox
]])

vim.cmd([[
	autocmd VimEnter * ++nested set fcs=eob:\ ,fold:\
]])

vim.cmd([[
	autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
]])

vim.cmd([[
	autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
]])

vim.cmd([[
	autocmd FileType vue setlocal ts=2 sts=2 sw=2 expandtab
]])

vim.cmd([[
	autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
]])

vim.cmd([[
    colorscheme gruvbox
]])

vim.cmd([[
	autocmd ColorScheme * highlight SignColumn guibg=NONE
]])

vim.cmd([[
	autocmd VimEnter * highlight TreesitterContext guibg=#353A3C
]])

vim.api.nvim_create_autocmd({
	"VimLeave",
}, {
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			local name = vim.api.nvim_buf_get_name(buf)
			local ft = vim.bo[buf].filetype

			if name ~= "" and vim.fn.buflisted(buf) == 1 and vim.bo[buf].modifiable and vim.bo[buf].modified then
				local excluded = false
				for _, ex in ipairs(excluded_filetypes) do
					if ft == ex then
						excluded = true
						break
					end
				end

				if not excluded then
					pcall(require("conform").format, {
						bufnr = buf,
						async = false,
						timeout_ms = 500,
						formatters = { "trim_whitespace", "trim_newlines" },
					})
				end
			end
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
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

local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
vim.api.nvim_create_autocmd("User", {
  pattern = "NvimTreeSetup",
  callback = function()
    local events = require("nvim-tree.api").events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})

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
