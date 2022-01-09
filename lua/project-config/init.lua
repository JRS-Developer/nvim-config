require("project_nvim").setup()

-- To enable telescope integration:
require("telescope").load_extension("projects")
vim.api.nvim_set_keymap("n", "<leader>fp", ":Telescope projects<cr>", { noremap = true })
