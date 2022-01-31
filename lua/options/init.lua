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
vim.o.scrolloff = 8 -- Scroll off

-- Searching
vim.o.incsearch = true -- Searching
vim.o.hlsearch = false -- Highlight search

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

vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable undo file
vim.opt.wrap = false -- disable line wrapping
vim.opt.showmode = false -- show mode
vim.opt.updatetime = 300 -- time to wait for a redraw (in milliseconds)
vim.opt.backup = false -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false -- creates a swapfile

vim.cmd("autocmd BufWinLeave *.* silent! mkview!") -- Create a view for each file
vim.cmd("autocmd BufWinEnter *.* silent! loadview") -- Load the view for each file
