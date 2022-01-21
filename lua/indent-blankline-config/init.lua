vim.opt.termguicolors = true

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup({
	space_char_blankline = " ",
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
	buftype_exclude = { "terminal", "prompt", "nofile", "help" },
	filetype_exclude = {
		"dashboard",
		"NvimTree",
		"NeogitStatus",
		"lspinfo",
	},
})
