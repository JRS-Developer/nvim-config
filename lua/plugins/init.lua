local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin-config")
		end,
	},

	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("devicons-config")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer-config")
		end,
	},

	{

		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent-blankline-config")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			require("nvim-tree-config")
		end,
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		ft = { "netrw" },
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim" },
		config = function()
			require("telescope-config")
		end,
		cmd = "Telescope",
	},

	-- Sintax
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"p00f/nvim-ts-rainbow",
		},
		config = function()
			require("treesitter-config")
		end,
	},

	-- LSP
	{
		"williamboman/mason.nvim",
		config = function()
			require("lsp-config")
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"b0o/SchemaStore.nvim", -- Json schemas
		},
	},
	{
		"glepnir/lspsaga.nvim",
		config = function()
			require("lsp-saga-config")
		end,
		event = "BufRead",
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				hint_prefix = "🐢 ",
			})
		end,
		dependencies = "mason-lspconfig.nvim",
	},
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble-config")
		end,
		cmd = "Trouble",
	},

	-- Formatting, Diagnostics and Code Analysis, The best of both worlds!
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls-config")
		end,
	},

	-- Completion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	{
		"hrsh7th/cmp-nvim-lua",
		ft = { "lua", "vim", "nvim" },
	},
	{ "David-Kunz/cmp-npm", dependencies = { "nvim-lua/plenary.nvim" } },
	"hrsh7th/nvim-cmp",

	-- Copilot
	{
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
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	"onsails/lspkind-nvim",

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luaSnip-config")
		end,
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	"rafamadriz/friendly-snippets",
	"saadparwaiz1/cmp_luasnip",

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- Tabs
	{
		"akinsho/bufferline.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline-config")
		end,
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		keys = { "gc", "gb" },
		config = function()
			require("Comment-config")
		end,
	},

	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},

	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine-config")
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns-config")
		end,
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("neogit-config")
		end,
		cmd = "Neogit",
	},

	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup()
		end,
	},

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- Cursor
	"RRethy/vim-illuminate",

	-- Search And Replace
	"windwp/nvim-spectre",

	-- Debugger
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("dap-config")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
		dependencies = "nvim-dap",
	},

	-- Keymaps
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key-config")
		end,
		keys = { "<leader>" },
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		version = "v2.*",
		config = function()
			require("toggleterm-config")
		end,
	},
})
