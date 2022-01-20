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

		use("nvim-lua/plenary.nvim") -- Many plugins require plenary.

		-- Themes And Colors
		use({
			"marko-cerovac/material.nvim",
			config = function()
				require("material").setup({
					italics = {
						comments = true, -- Enable italic comments
						keywords = false, -- Enable italic keywords
						functions = true, -- Enable italic functions
						strings = false, -- Enable italic strings
						variables = false, -- Enable italic variables
					},
					-- disable = {
					-- 	background = true, -- Disable background colors
					-- },
				})

				vim.g.material_style = "deep ocean"
				-- vim.g.material_disable_background = true -- En windows no tengo modo transparente
				-- vim.cmd("colorscheme material")
			end,
		})

		use({
			"folke/tokyonight.nvim",
			config = function()
				vim.g.tokyonight_style = "night"
				-- vim.cmd([[colorscheme tokyonight]])
			end,
		})

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
			config = function()
				require("colorizer").setup()
			end,
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			config = "require('indent-blankline-config')",
		})

		use("p00f/nvim-ts-rainbow")

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
			requires = { "windwp/nvim-ts-autotag" },
			config = "require('treesitter-config')",
		})

		-- LSP
		use({
			"neovim/nvim-lspconfig",
			config = "require('lsp-config')",
		})
		use({
			"tami5/lspsaga.nvim",
			branch = "nvim6.0",
			config = "require('lsp-saga-config')",
		})
		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({
					hint_prefix = "🐢 ",
				})
			end,
		})
		use("b0o/SchemaStore.nvim") -- Json schemas
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = "require('trouble-config')",
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
		use("hrsh7th/cmp-nvim-lua")
		use({ "David-Kunz/cmp-npm", requires = { "nvim-lua/plenary.nvim" } })
		use("hrsh7th/nvim-cmp")
		use("github/copilot.vim")
		use("onsails/lspkind-nvim")

		-- Snippets
		use({
			"L3MON4D3/LuaSnip",
			config = "require('luaSnip-config')",
		})
		use("rafamadriz/friendly-snippets")
		use("saadparwaiz1/cmp_luasnip")

		-- Tags
		use({
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		})
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
			"JoosepAlviste/nvim-ts-context-commentstring",
			after = "nvim-treesitter",
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
		})

		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim", config = "require('diffview-config')" })

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		})

		-- Cursor
		use("xiyaowong/nvim-cursorword")

		-- Search And Replace
		use({ "windwp/nvim-spectre", config = "require('spectre-config')" })

		-- Debugger
		use({
			"mfussenegger/nvim-dap",
			config = "require('dap-config')",
		})

		use({
			"rcarriga/nvim-dap-ui",
			requires = { "mfussenegger/nvim-dap" },
			config = function()
				require("dapui").setup()
			end,
		})

		use({
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup()
			end,
		})

		-- Terminal
		use({ "akinsho/toggleterm.nvim", config = "require('toggleterm-config')" })

		-- Scroll
		use({ "petertriho/nvim-scrollbar", config = "require('scrollbar-config')" })

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		git = {
			clone_timout = 1000,
		},
	},
})
