-- Utility function for creating autocommands
local function create_augroup(name, autocmds)
	local augroup = vim.api.nvim_create_augroup(name, { clear = true })
	for _, autocmd in ipairs(autocmds) do
		local event = autocmd[1]
		local opts = autocmd[2] or {}
		opts.group = augroup
		vim.api.nvim_create_autocmd(event, opts)
	end
end

-- Colors and highlighting
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

-- Theme setup
create_augroup("ThemeSetup", {
	{
		"VimEnter",
		{
			nested = true,
			callback = function()
				vim.cmd("colorscheme gruvbox")
				vim.opt.fillchars = { eob = " ", fold = " " }
			end,
		},
	},
	{ "UIEnter", {
		nested = true,
		callback = function()
			vim.cmd("colorscheme gruvbox")
		end,
	} },
	{
		"ColorScheme",
		{
			callback = function()
				-- Sign column transparency
				vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

				-- Floating windows
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.bg, fg = colors.fg })

				-- Blink completion menu
				local blink_hl = {
					Menu = { bg = colors.bg, fg = colors.fg },
					MenuBorder = { fg = colors.gray, bg = colors.bg },
					MenuSelection = { bg = colors.dark_gray, fg = colors.yellow, bold = true },
					ScrollBarThumb = { bg = colors.scrollbar },
					ScrollBarGutter = { bg = colors.bg },
					Label = { fg = colors.fg },
					LabelDeprecated = { fg = colors.gray, strikethrough = true },
					LabelMatch = { fg = colors.yellow, bold = true },
					LabelDetail = { fg = colors.gray },
					LabelDescription = { fg = colors.gray },
					Kind = { fg = colors.green },
					KindFunction = { fg = colors.green },
					KindMethod = { fg = colors.green },
					KindVariable = { fg = colors.blue },
					KindField = { fg = colors.purple },
					KindClass = { fg = colors.orange },
					KindInterface = { fg = colors.orange },
					KindText = { fg = colors.fg },
					Source = { fg = colors.gray },
					GhostText = { fg = colors.gray, italic = true },
					Doc = { bg = colors.bg, fg = colors.fg },
					DocBorder = { fg = colors.gray, bg = colors.bg },
					DocSeparator = { fg = colors.gray },
					DocCursorLine = { bg = colors.dark_gray },
					SignatureHelp = { bg = colors.bg, fg = colors.fg },
					SignatureHelpBorder = { fg = colors.gray, bg = colors.bg },
					SignatureHelpActiveParameter = { fg = colors.yellow, underline = true },
				}

				for name, hl in pairs(blink_hl) do
					vim.api.nvim_set_hl(0, "BlinkCmp" .. name, hl)
				end

				-- Git signs
				vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "gray" })

				-- Fidget
				vim.api.nvim_set_hl(0, "FidgetDoneStyle", { fg = "#98C379" })

				-- DAP
				local dap_hl = {
					BreakpointColor = { fg = "#e45555" },
					BreakpointConditionColor = { fg = "#E5C07B" },
					BreakpointRejectedColor = { fg = "#BE5046" },
					LogPointColor = { fg = "#56B6C2" },
					StoppedColor = { fg = "#98C379", bold = true },
					StoppedLine = { bg = colors.bg },
				}

				for name, hl in pairs(dap_hl) do
					vim.api.nvim_set_hl(0, "Dap" .. name, hl)
				end

				-- Diagnostic signs
				local diagnostic_signs = {
					"DiagnosticSignWarn",
					"DiagnosticSignError",
					"DiagnosticSignHint",
					"DiagnosticSignInfo",
					"DiagnosticSignOk",
				}

				for _, group in ipairs(diagnostic_signs) do
					local current = vim.api.nvim_get_hl(0, { name = group, link = false })
					vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", current, { bg = "none" }))
				end

				-- Diff highlighting
				vim.api.nvim_set_hl(0, "DiffAdd", { bg = colors.blue, fg = colors.fg })
				vim.api.nvim_set_hl(0, "DiffText", { bg = colors.orange, fg = colors.fg })
			end,
		},
	},
})

-- Formatting and linting
create_augroup("Formatting", {
	{
		"BufWritePost",
		{
			callback = function(args)
				-- Trim whitespace and newlines
				pcall(require("conform").format, {
					bufnr = args.buf,
					async = false,
					timeout_ms = 500,
					formatters = { "trim_whitespace", "trim_newlines" },
				})

				-- Run linter
				require("lint").try_lint()
			end,
		},
	},
	{
		"BufWritePre",
		{
			pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
			callback = function(args)
				local bufnr = args.buf
				local clients = vim.lsp.get_clients({ bufnr = bufnr })
				local tsserver = vim.tbl_filter(function(client)
					return client.name == "tsserver"
				end, clients)[1]

				if not tsserver then
					return
				end

				local uri = vim.uri_from_bufnr(bufnr)
				local commands = {
					{ command = "vtsls.addMissingImports", arguments = { vim.api.nvim_buf_get_name(bufnr) } },
					{ command = "vtsls.organizeImports", arguments = { uri } },
					{ command = "vtsls.removeUnused", arguments = { uri } },
				}

				for _, cmd in ipairs(commands) do
					vim.lsp.buf_request(bufnr, "workspace/executeCommand", cmd, function(err)
						if err then
							vim.notify(
								string.format(
									"%s failed: %s",
									cmd.command:gsub("^vtsls%.", ""):gsub("(%u)", " %1"):gsub("^%l", string.upper),
									err.message
								),
								vim.log.levels.WARN
							)
						end
					end)
				end

				-- Format with conform
				require("conform").format({ bufnr = bufnr })
			end,
		},
	},
})

-- Auto-refresh for file changes
create_augroup("AutoRefresh", {
	{
		{ "FocusGained", "BufEnter", "CursorHold" },
		{
			callback = function()
				vim.cmd("silent! checktime")
			end,
			desc = "Auto-reload files changed outside of Neovim",
		},
	},
	{
		"FileChangedShellPost",
		{
			callback = function(args)
				vim.notify(
					("File reloaded: %s"):format(args.file or vim.api.nvim_buf_get_name(0)),
					vim.log.levels.INFO,
					{ title = "autoread" }
				)
			end,
			desc = "Notify on external file change reload",
		},
	},
})

-- Custom commands
vim.api.nvim_create_user_command("CloseFindReplace", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(buf)
		if name:match("Find and Replace") then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, {})

-- NeoTree highlighting
vim.cmd([[
  highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
  highlight! link NeoTreeDirectoryName NvimTreeFolderName
  highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
  highlight! link NeoTreeRootName NvimTreeRootFolder
  highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
  highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
]])

vim.api.nvim_create_autocmd("FileType", {
  pattern = "codecompanion",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*CodeCompanion*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})
