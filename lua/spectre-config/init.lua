require('spectre').setup()

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


map('n', '<leader>S', ':lua require("spectre").open()<CR>', opts)
-- search current word
map('n', '<leader>s', ':lua require("spectre").open_visual({select_word=true})<CR>', opts) 
