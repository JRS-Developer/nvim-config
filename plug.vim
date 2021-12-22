call plug#begin(stdpath('data') . '/plugged')

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim', {'branch': 'nvim6.0'}
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'folke/trouble.nvim'

"Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'onsails/lspkind-nvim'

" Sintax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-lua/plenary.nvim'

" Theme & Icons
Plug 'catppuccin/nvim'
Plug 'folke/tokyonight.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'akinsho/bufferline.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'marko-cerovac/material.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" Exploration
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-tree.lua', {'commit': 'b853e10'}

" Comments
Plug 'numToStr/Comment.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'folke/todo-comments.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Formating
Plug 'mhartington/formatter.nvim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'Pocco81/DAPInstall.nvim'

" Other
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-ts-autotag'
Plug 'windwp/nvim-autopairs'

call plug#end()
