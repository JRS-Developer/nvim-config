vim.g.mapleader = " "

-- Left side
vim.o.relativenumber = true
vim.o.number = true
vim.o.signcolumn = "yes" -- Space for lsp icons

-- Ident
vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.expandtab = true

-- Scroll
vim.o.scrolloff = 8

-- Searching
vim.o.incsearch = true
vim.o.hlsearch = false

-- ETC
vim.o.hidden = true
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.o.completeopt = "menuone,noinsert,noselect"


vim.cmd [[hi Normal guibg=NONE guifg=NONE ctermbg=NONE term=NONE gui=NONE]]
