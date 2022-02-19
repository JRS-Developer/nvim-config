local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local packer = require("packer")

return packer.startup({
	function(use)
		use("wbthomason/packer.nvim")

		use({
			"lewis6991/impatient.nvim", -- Speed up startup! :D
		})

		use({
			"glepnir/dashboard-nvim", -- Dashboard
			config = "require('dashboard-config')",
		})

		-- Themes And Colors
		use({
			"catppuccin/nvim",
			as = "catppuccin",
			config = "require('catppuccin-config')",
		})

		use({
			"kyazdani42/nvim-web-devicons",
			config = "require('devicons-config')",
		})

		use({
			"norcalli/nvim-colorizer.lua",
			config = "require('colorizer-config')",
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			config = "require('indent-blankline-config')",
		})

		-- Exploration
		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons", -- optional, for file icon
			},
			config = "require('nvim-tree-config')",
		})
		use({
			"nvim-telescope/telescope.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = "require('telescope-config')",
		})

		-- Projects
		use({
			"ahmedkhalf/project.nvim",
			config = "require('project-config')",
		})

		-- Sintax
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			requires = {
				"windwp/nvim-ts-autotag",
				"JoosepAlviste/nvim-ts-context-commentstring",
				"p00f/nvim-ts-rainbow",
			},
			config = "require('treesitter-config')",
		})

		-- LSP
		use({
			"williamboman/nvim-lsp-installer",
			config = "require('lsp-config')",
			requires = {
				"neovim/nvim-lspconfig",
				"b0o/SchemaStore.nvim", -- Json schemas
			},
		})
		use({
			"tami5/lspsaga.nvim",
			branch = "nvim6.0",
			config = "require('lsp-saga-config')",
			after = "nvim-lsp-installer",
		})
		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({
					hint_prefix = "🐢 ",
				})
			end,
			after = "nvim-lsp-installer",
		})
		use({
			"kosayoda/nvim-lightbulb",
			config = function()
				vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
			end,
		})
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = "require('trouble-config')",
			cmd = "Trouble",
		})

		-- Formatting, Diagnostics and Code Analysis, The best of both worlds!
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = "require('null-ls-config')",
		})

		-- Completion
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use({
			"hrsh7th/cmp-nvim-lua",
			ft = { "lua", "vim", "nvim" },
		})
		use({ "David-Kunz/cmp-npm", requires = { "nvim-lua/plenary.nvim" } })
		use("hrsh7th/nvim-cmp")
		use({
			"github/copilot.vim",
			setup = function()
				vim.cmd([[
          imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
          let g:copilot_no_tab_map = v:true
        ]])
			end,
		})
		use("onsails/lspkind-nvim")

		-- Snippets
		use({
			"L3MON4D3/LuaSnip",
			config = "require('luaSnip-config')",
			requires = "rafamadriz/friendly-snippets",
		})
		use("saadparwaiz1/cmp_luasnip")

		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({
					check_ts = true,
				})
			end,
		})
		use("tpope/vim-surround") -- surround characters shortcuts

		-- Tabs
		use({
			"akinsho/bufferline.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = "require('bufferline-config')",
		})

		-- Comments
		use({
			"numToStr/Comment.nvim",
			config = "require('Comment-config')",
		})

		use({
			"folke/todo-comments.nvim",
			config = function()
				require("todo-comments").setup()
			end,
		})

		-- Lualine
		use({
			"nvim-lualine/lualine.nvim",
			config = "require('lualine-config')",
		})

		-- Git
		use({
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
			config = "require'gitsigns-config'",
		})

		use({
			"TimUntersberger/neogit",
			requires = {
				"nvim-lua/plenary.nvim",
				"sindrets/diffview.nvim",
			},
			config = "require('neogit-config')",
			cmd = "Neogit",
		})

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
			cmd = "MarkdownPreview",
		})

		-- Cursor
		use("xiyaowong/nvim-cursorword")

		-- Search And Replace
		use("windwp/nvim-spectre")

		-- Debugger
		use({
			"mfussenegger/nvim-dap",
			requires = {
				"Pocco81/DAPInstall.nvim",
			},
			config = "require('dap-config')",
		})

		use({
			"rcarriga/nvim-dap-ui",
			requires = { "mfussenegger/nvim-dap" },
			config = function()
				require("dapui").setup()
			end,
			after = "nvim-dap",
		})

		use({
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup()
			end,
			after = "nvim-dap",
		})

		-- Scroll
		use({ "petertriho/nvim-scrollbar", config = "require('scrollbar-config')" })

		-- Keymaps
		use({
			"folke/which-key.nvim",
			config = "require('which-key-config')",
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		git = {
			clone_timout = 1000,
		},
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
