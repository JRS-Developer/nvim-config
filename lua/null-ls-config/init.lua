local null_ls = require("null-ls")

local sources = {
	-- Formatters
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.black,
	null_ls.builtins.formatting.gofmt,
	null_ls.builtins.formatting.prettierd.with({
		prefer_local = "node_modules/.bin",
	}),
	-- Diagnostics
	null_ls.builtins.diagnostics.luacheck,
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
