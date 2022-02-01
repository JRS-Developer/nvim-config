local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- slp saga
	buf_set_keymap("n", "<leader>ca", ":Lspsaga code_action<CR>", { silent = true, noremap = true })
	buf_set_keymap("n", "gh", "<cmd>Lspsaga lsp_finder<cr>", { silent = true, noremap = true })

	buf_set_keymap("n", "gr", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true })

	buf_set_keymap("n", "<silent><leader>ca", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })

	buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })

	buf_set_keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
	buf_set_keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })

	buf_set_keymap(
		"n",
		"<C-u>",
		"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>",
		{ noremap = true }
	)
	buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", { noremap = true })

	vim.diagnostic.config({
		virtual_text = {
			prefix = "●", -- Could be '●', '▎', 'x'
		},
		signs = true,
		underline = true,
		update_in_insert = true,
	})

	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- Disable formatting
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

local cmp = require("cmp")
local lspkind = require("lspkind")
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

cmp.setup({
	formatting = {
		format = lspkind.cmp_format(),
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` uers.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "npm" },
	}),
})
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
	local opts = {}

	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	--     opts.root_dir = function() ... end
	-- end

	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = {
						vim = true,
						nvim = true,
					},
				},
			},
		}
	end

	if server.name == "jsonls" then
		opts.settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		}
	end

	if server.name == "volar" then
		opts.init_options = {
			typescript = {
				serverPath = "/usr/lib/node_modules/typescript/lib/tsserverlibrary.js",
			},
		}
	end

	opts.on_attach = on_attach
	opts.capabilities = capabilities
	opts.root_dir = vim.loop.cwd
	-- This setup() function will take the provided server configuration and decorate it with the necessary properties
	-- before passing it onwards to lspconfig.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

-- Install the servers that are not installed yet.
local servers = {
	"tsserver",
	"vimls",
	"cssls",
	"eslint",
	"html",
	-- "cssmodules_ls",
	-- "stylelint_lsp",
	"tailwindcss",
	"emmet_ls",
	"pyright",
	"gopls",
	"golangci_lint_ls",
	"intelephense",
	"volar",
	"jsonls",
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found and not server:is_installed() then
		print("Installing " .. name)
		server:install()
	end
end
-- for _, lsp in ipairs(servers) do
-- 	nvim_lsp[lsp].setup({
-- 		on_attach = on_attach,
-- 		flags = {
-- 			debounce_text_changes = 150,
-- 		},
-- 		root_dir = vim.loop.cwd,
-- 		capabilities = capabilities,
-- 	})
-- end

-- Config JSONls
-- nvim_lsp.jsonls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- 	root_dir = vim.loop.cwd,
-- 	settings = {
-- 		json = {
-- 			schemas = require("schemastore").json.schemas(),
-- 		},
-- 	},
-- })
