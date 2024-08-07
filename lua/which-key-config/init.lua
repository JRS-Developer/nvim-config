local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

-- Reads the .vscode/launch.json file and loads it into dap
local continue = function()
	if vim.fn.filereadable(".vscode/launch.json") then
		require("dap.ext.vscode").load_launchjs(nil, { node = { "javascript", "node2" } })
	end
	require("dap").continue()
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>", -- key prefix
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	p = {
		name = "Lazy",
		s = { "<cmd>Lazy sync<cr>", "Sync" },
		S = { "<cmd>Lazy home<cr>", "Status" },
		u = { "<cmd>Lazy update<cr>", "Update" },
	},
	f = {
		name = "File",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		g = { "<cmd>Telescope live_grep<cr>", "Find Word" },
		b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Tag" },
	},
	t = {
		"<cmd>ToggleTerm<cr>",
		"ToggleTerm",
	},
	x = {
		name = "Trouble",
		x = { "<cmd>Trouble<cr>", "Trouble" },
		w = { "<cmd>Trouble workspace_diagnostics<cr>", "Trouble Workspace Diagnostics" },
		d = { "<cmd>Trouble document_diagnostics<cr>", "Trouble Document Diagnostics" },
		l = { "<cmd>Trouble locklist<cr>", "Trouble Locklist" },
		q = { "<cmd>Trouble quickfix<cr>", "Trouble Quickfix" },
		t = { "<cmd>Trouble telescope<cr>", "Trouble Telescope" },
	},
	g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "LazyGit" },
	s = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search Replace Current Word" },
	["S"] = { "<cmd>lua require('spectre').open()<cr>", "Search And Replace" },
	m = {
		name = "Markdown Preview",
		o = { "<cmd>MarkdownPreview<cr>", "Open" },
		s = { "<cmd>MarkdownPreviewStop<cr>", "Stop" },
		t = { "<cmd>MarkdownPreview<cr>", "Toggle" },
	},
	n = {
		n = { "<cmd>NvimTreeToggle <cr>", "NvimTreeToggle" },
		r = { "<cmd>NvimTreeRefresh <cr>", "NvimTreeRefresh" },
	},
	d = {
		name = "DAP",
		c = { continue, "Continue" },
		t = { ':lua require("dap").terminate()<CR>', "Terminate" },
		l = { ':lua require("dap").run_last()<CR>', "Run Last Debugging Config" },
		d = { ':lua require("dap").repl.open()<CR>', "Open Debug Console" },
		b = {
			name = "Breakpoint",
			t = { ':lua require("dap").toggle_breakpoint()<CR>', "Toggle" },
			c = {
				':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
				"Set conditional",
			},
			l = {
				':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
				"With Log Point Message",
			},
		},
		s = {
			name = "Step",
			o = { ':lua require("dap").step_over()<CR>', "Step Over" },
			O = { ':lua require("dap").step_into()<CR>', "Step Into" },
			i = { ':lua require("dap").step_out()<CR>', "Step Out" },
			b = { ':lua require("dap").step_back()<CR>', "Step Back" },
			c = { ':lua require("dap").run_to_cursor()<CR>', "Run To Cursor" },
		},
		u = { ':lua require("dapui").toggle()<CR>', "Toggle UI" },
	},
	c = {
		name = "BufferLine Close",
		l = { "<cmd>BufferLineCloseLeft<cr>", "Close Left" },
		r = { "<cmd>BufferLineCloseRight<cr>", "Close Right" },
	},
	cc = {
		name = "Copilot Chat",
		q = {
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end,
			"Quick Chat",
		},
		o = {
			"<cmd>CopilotChatOpen<cr>",
			"Open Chat",
		},
	},
}

which_key.register(mappings, opts)
which_key.setup(setup)
