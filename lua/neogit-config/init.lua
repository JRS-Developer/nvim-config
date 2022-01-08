local neogit = require('neogit')

neogit.setup {
  integrations = {
    diffview = true
  },
  kind = "vsplit",
}

vim.api.nvim_set_keymap("n", "<leader>g", ":Neogit kind=vsplit <CR>", { silent = true, noremap = true })
