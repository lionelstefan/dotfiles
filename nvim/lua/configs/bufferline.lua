require("bufferline").setup({
	options = {
		numbers = "none",
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		indicator_icon = "▎",
		buffer_close_icon = "X",
		modified_icon = "M",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 25,
		diagnostics = false,
		diagnostics_update_in_insert = false,
		show_buffer_icons = false, -- disable filetype icons for buffers
		show_buffer_close_icons = true,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
		separator_style = "thick",
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		sort_by = "insert_at_end",
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				text_align = "left",
				separator = true,
			},
		},
	},
})
