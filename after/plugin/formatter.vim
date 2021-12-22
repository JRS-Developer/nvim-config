lua << EOF

local prettier = function()
return {
	exe = "prettier",
	args = {"--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0))},
	stdin = true
	}
	  end


require('formatter').setup{
  logging = false,
  filetype = {
    javascript = {
        -- prettier
	prettier
       	},
	javascriptreact = {
		prettier
		},
	typescript = {
		prettier
		},
	typescriptreact = {
		prettier
		},
	css = {
		prettier
		},
	html = {
		prettier
		}
}
}

EOF

nnoremap <silent> <leader>p :Format<CR>
