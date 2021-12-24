local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require('packer')

return packer.startup(function(use) 
	use 'wbthomason/packer.nvim'

  -- Themes And Colors
	use {
    'marko-cerovac/material.nvim', 
    config = function()
    require'material'.setup()
    vim.g.material_style = "deep ocean"
    vim.cmd 'colorscheme material'
  end
  }
  use {
    'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end
  }


  -- Exploration
	use  {
	'kyazdani42/nvim-tree.lua', commit = 'b853e10',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = "require('nvim-tree-config')",
	}
  use {
    'nvim-telescope/telescope.nvim',
    requires =  {'nvim-lua/plenary.nvim'},
    config = "require('telescope-config')"
  }

  -- Sintax
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {'windwp/nvim-ts-autotag'},
    config = "require('treesitter-config')",
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig', config = "require('lsp-config')"
  }
  use {
    'tami5/lspsaga.nvim', branch = "nvim6.0", config = "require('lsp-saga-config')"
  }
  use {
    'ray-x/lsp_signature.nvim', config = function() require "lsp_signature".setup()
 end
  } 
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}

      -- Keymaps
      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
      {silent = true, noremap = true}
      )
    end
  }

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'

  -- Snippets
  use  {
  'L3MON4D3/LuaSnip', config = "require('luaSnip-config')"
  }
  use "rafamadriz/friendly-snippets"
  use 'saadparwaiz1/cmp_luasnip'

  -- Tags
  use {
    'windwp/nvim-ts-autotag', config = function() require'nvim-ts-autotag'.setup() end
  } 
  use {
    'windwp/nvim-autopairs', config = function() require'nvim-autopairs'.setup({
      check_ts = true
    }) end
  } 
  use 'tpope/vim-surround' -- surround characters shortcuts

  -- Tabs
  use {'akinsho/bufferline.nvim', 
    requires = 'kyazdani42/nvim-web-devicons', 
    config = "require('bufferline-config')"
  }

  -- Comments
  use {
    'numToStr/Comment.nvim', config = "require('Comment-config')"
    }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring', after = "nvim-treesitter"
  }
    
  use {
    'folke/todo-comments.nvim', config = function() require'todo-comments'.setup() end
    } 

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim', config = "require('lualine-config')"
  } 

  -- Git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require'gitsigns'.setup() end
  }

  -- Formatting
  use {
    'mhartington/formatter.nvim', config = "require('formatter-config')"
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
