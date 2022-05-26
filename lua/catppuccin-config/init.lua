local catppuccin = require("catppuccin")

-- configure it
catppuccin.setup({
	transparent_background = false,
	term_colors = true,
	styles = {
		comments = "italic",
		conditionals = "italic",
		loops = "NONE",
		functions = "NONE",
		keywords = "NONE",
		strings = "NONE",
		variables = "NONE",
		numbers = "NONE",
		booleans = "NONE",
		properties = "NONE",
		types = "NONE",
		operators = "NONE",
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = "italic",
				hints = "italic",
				warnings = "italic",
				information = "italic",
			},
			underlines = {
				errors = "underline",
				hints = "underline",
				warnings = "underline",
				information = "underline",
			},
		},
		lsp_trouble = true,
		cmp = true,
		lsp_saga = true,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = false,
			transparent_panel = false,
		},
		neotree = {
			enabled = false,
			show_root = false,
			transparent_panel = false,
		},
		which_key = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		dashboard = true,
		neogit = true,
		vim_sneak = false,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = true,
		lightspeed = false,
		ts_rainbow = true,
		hop = false,
		notify = false,
		telekasten = false,
		symbols_outline = false,
	},
})

vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
vim.cmd([[colorscheme catppuccin]])
