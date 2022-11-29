-- configure it
require("catppuccin").setup({
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
	transparent_background = false,
	term_colors = true,
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		lsp_saga = true,
		neogit = true,
		telescope = true,
		cmp = true,
		mason = true,
		markdown = true,
		gitsigns = true,
		dashboard = true,
		nvimtree = true,
		treesitter = true,
		which_key = true,
		illuminate = true,
		dap = {
			enabled = false,
			enable_ui = false,
		},
		ts_rainbow = true,
		indent_blankline = {
			enabled = false,
			colored_indent_levels = false,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
	},
	color_overrides = {},
	highlight_overrides = {},
})
vim.api.nvim_command("colorscheme catppuccin")
