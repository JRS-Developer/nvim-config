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
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("devicons-config")
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer-config")
		end,
	},

	-- Motion
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "o" },
				function()
					require("flash").jump({
						search = { -- Match beginning of words only
							mode = function(str)
								return "\\<" .. str
							end,
						},
					})
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	{

		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("indent-blankline-config")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icon
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
		},
		config = function()
			require("treesitter-config")
		end,
	},
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh yarn",
		-- if on windows
		-- build = 'pwsh install.ps1 yarn',
		config = true,
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
			-- "jose-elias-alvarez/typescript.nvim",
			"b0o/SchemaStore.nvim", -- Json schemas
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lsp-saga-config")
		end,
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optionalpl
		},
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
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble-config")
		end,
		cmd = "Trouble",
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		config = function()
			require("ts-error-translator").setup()
		end,
	},

	-- Formatting, Diagnostics and Code Analysis, The best of both worlds!
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
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
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
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
		event = "InsertEnter",
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
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline-config")
		end,
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		keys = { -- example keymaps for lazy loading this plugin.
			{ "gcc", mode = "n", desc = "Toggles the current line using linewise comment" },
			{ "gbc", mode = "n", desc = "Toggles the current line using blockwise comment" },
			{ "gc", mode = "v", desc = "Toggles the region using linewise comment" },
			{ "gb", mode = "v", desc = "Toggles the region using blockwise comment" },
		},
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
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({})
		end,
	},

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
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
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

	{ "wakatime/vim-wakatime", lazy = false },
})
