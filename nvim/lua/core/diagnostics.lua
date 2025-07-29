local signs = {
	Error = " ",
	Warn = " ",
	Hint = "󰌵 ",
	Info = " ",
}

local signConf = {
	text = {},
	texthl = {},
	numhl = {},
}

for type, icon in pairs(signs) do
	local severityName = string.upper(type)
	local severity = vim.diagnostic.severity[severityName]
	local hl = "DiagnosticSign" .. type
	signConf.text[severity] = icon
	signConf.texthl[severity] = hl
	signConf.numhl[severity] = hl
end

vim.diagnostic.config({
	virtual_text = false,
	signs = signConf,
	underline = true,
	severity_sort = true,
})


