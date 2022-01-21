vim.g.mapleader = " "

-- Left side
-- vim.o.relativenumber = true -- It is lagging the scroll :(
vim.o.number = true
vim.o.lazyredraw = true -- Speed scroll
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

-- Cursor
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- ETC
vim.o.hidden = true
vim.o.clipboard = "unnamedplus" -- Allow copy/paste from other programs
vim.o.termguicolors = true
vim.o.completeopt = "menuone,noinsert,noselect"

vim.opt.mouse = "a" -- Allow to use the mouse

vim.o.foldmethod = "manual"
vim.o.foldcolumn = "auto"

vim.cmd("autocmd BufWinLeave *.* mkview!") -- Create a view for each file
vim.cmd("autocmd BufWinEnter *.* silent loadview") -- Load the view for each file
