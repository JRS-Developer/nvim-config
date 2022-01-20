vim.g.nvim_tree_respect_buf_cwd = 1

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	update_to_buf_dir = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = true,
		side = "left",
		auto_resize = true,
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})

vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeFindFile<CR>", { noremap = true })
