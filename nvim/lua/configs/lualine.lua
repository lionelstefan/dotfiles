require("lualine").setup {
	options = {
		icons_enabled = true,
		theme = 'gruvbox_dark',
		component_separators = { 
			left = '',
			right = ''
		},
		section_separators  = { 
			left = '',
			right = ''
		}
	},
	sections = {
		lualine_b = {
			'branch',
			{
				'diff',
				colored = false
			}
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
	}
}
