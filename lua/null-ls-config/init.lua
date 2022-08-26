local null_ls = require("null-ls")
local builtins = null_ls.builtins

local sources = {
	-- Formatters
	builtins.formatting.stylua, --Lua
	builtins.formatting.black, --Python
	builtins.formatting.gofmt, --Go
	builtins.formatting.prettierd.with({
		prefer_local = "node_modules/.bin",
		extra_filetypes = { "prisma" },
	}),
	builtins.formatting.phpcbf, -- Php Code Sniffer Formatter
	builtins.formatting.phpcsfixer, -- Php Code Sniffer Formatter (PHP-CS-Fixer)

	-- Diagnostics
	builtins.diagnostics.phpcs, -- Php Code Sniffer Linter
	builtins.diagnostics.phpmd.with({
		extra_args = { "phpmd.xml" },
	}), -- Php Mess Detector
	builtins.diagnostics.pylama, -- Python linter, useful?
}

null_ls.setup({
	sources = sources,
})
