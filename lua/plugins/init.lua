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

		-- Editor Config
		use("editorconfig/editorconfig-vim")

		-- Themes And Colors
		use({
			"catppuccin/nvim",
			as = "catppuccin",
			run = ":CatppuccinCompile",
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
			cmd = { "NvimTreeToggle", "NvimTreeFocus" },
			ft = { "netrw" },
		})
		use({
			"nvim-telescope/telescope.nvim",
			requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim" },
			config = "require('telescope-config')",
			cmd = "Telescope",
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
			"williamboman/mason.nvim",
			config = "require('lsp-config')",
			requires = {
				"neovim/nvim-lspconfig",
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				"b0o/SchemaStore.nvim", -- Json schemas
			},
		})
		use({
			"glepnir/lspsaga.nvim",
			config = "require('lsp-saga-config')",
			after = "mason-lspconfig.nvim",
		})
		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({
					hint_prefix = "🐢 ",
				})
			end,
			after = "mason-lspconfig.nvim",
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

		-- Copilot
		use({
			"zbirenbaum/copilot.lua",
			event = { "VimEnter" },
			config = function()
				vim.defer_fn(function()
					require("copilot").setup({
						cmp = {
							enabled = true,
							method = "getCompletionsCycling",
						},
					})
				end, 100)
			end,
		})
		use({
			"zbirenbaum/copilot-cmp",
			after = { "copilot.lua" },
			config = function()
				require("copilot_cmp").setup()
			end,
		})

		use("onsails/lspkind-nvim")

		-- Snippets
		use({
			"L3MON4D3/LuaSnip",
			config = "require('luaSnip-config')",
			requires = "JRS-Developer/friendly-snippets",
		})
		use("rafamadriz/friendly-snippets")
		use("saadparwaiz1/cmp_luasnip")

		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({
					check_ts = true,
				})
			end,
		})
		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		})
		-- Tabs
		use({
			"akinsho/bufferline.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = "require('bufferline-config')",
		})

		-- Comments
		use({
			"numToStr/Comment.nvim",
			keys = { "gc", "gb" },
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
			},
			config = "require('neogit-config')",
			cmd = "Neogit",
			opt = true,
		})

		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

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
		use("RRethy/vim-illuminate")

		-- Search And Replace
		use("windwp/nvim-spectre")

		-- Debugger
		use({
			"mfussenegger/nvim-dap",
			requires = {
				"Pocco81/dap-buddy.nvim",
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

		-- Keymaps
		use({
			"folke/which-key.nvim",
			config = "require('which-key-config')",
			keys = { "<leader>" },
		})

		-- Terminal
		use({ "akinsho/toggleterm.nvim", tag = "v2.*", config = "require('toggleterm-config')" })

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		git = {
			clone_timeout = 1000,
		},
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
