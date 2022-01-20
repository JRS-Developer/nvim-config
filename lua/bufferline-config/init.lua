local colors = require("catppuccin.api.colors").get_colors()

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		close_icon = "",
		diagnostics_update_in_insert = true,
		offsets = { { filetype = "NvimTree" } },
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or "")
				s = s .. n .. sym
			end
			return s
		end,
	},
	highlights = {
		close_button = {
			guifg = colors.red,
		},
		close_button_selected = {
			guifg = colors.red,
		},
		tab_close = {
			guifg = colors.red,
			guibg = colors.black1,
		},
		modified = {
			guifg = colors.red,
		},

		modified_visible = {
			guifg = colors.red,
		},
		modified_selected = {
			guifg = colors.red,
		},
	},
})

vim.api.nvim_set_keymap("n", "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<A-c>", "<Cmd>BufferLinePickClose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-.>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-,>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true })
