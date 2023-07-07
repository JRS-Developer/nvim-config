vim.opt.termguicolors = true

vim.opt.list = true

require("indent_blankline").setup({
	show_end_of_line = true,
	buftype_exclude = { "terminal", "prompt", "nofile", "help" },
	filetype_exclude = {
		"dashboard",
		"NvimTree",
		"NeogitStatus",
		"lspinfo",
	},
})
