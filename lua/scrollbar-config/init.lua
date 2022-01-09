local colors = require("catppuccin.api.colors").get_colors() -- fetch colors with API

require("scrollbar").setup({
	handle = {
		color = colors.black0,
	},
	excluded_filetypes = {
		"NvimTree",
		"prompt",
		"TelescopePrompt",
	},
	marks = {
		Search = { color = colors.flamingo },
		Error = { color = colors.red },
		Warn = { color = colors.rosewater },
		Info = { color = colors.blue },
		Hint = { color = colors.teal },
		Misc = { color = colors.lavender },
	},
})
