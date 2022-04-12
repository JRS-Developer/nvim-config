local null_ls = require("null-ls")
local builtins = null_ls.builtins

local sources = {
	-- Formatters
	builtins.formatting.eslint_d,
	builtins.formatting.stylua, --Lua
	builtins.formatting.black, --Python
	builtins.formatting.gofmt, --Go
	builtins.formatting.prettierd.with({
		prefer_local = "node_modules/.bin",
	}),
	builtins.formatting.phpcbf, -- Php Code Sniffer Formatter
	builtins.formatting.phpcsfixer, -- Php Code Sniffer Formatter (PHP-CS-Fixer)
	builtins.formatting.rustywind, --Tailwind class order

	-- Linters
	builtins.diagnostics.eslint_d,
	builtins.diagnostics.phpcs, -- Php Code Sniffer Linter
	builtins.diagnostics.phpmd.with({
		extra_args = { "phpmd.xml" },
	}), -- Php Mess Detector
	builtins.diagnostics.pylama, -- Python linter, useful?
}

null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 10000)
            augroup END
            ]])
		end
	end,
	debug = true,
})
