lua << EOF
require("bufferline").setup{
options ={

	diagnostics = "nvim_lsp",
	diagnostics_update_in_insert = false,
	diagnostics_indicator = function(count, level, diagnostics_dict, context)
		local s = " "
		for e, n in pairs(diagnostics_dict) do
			local sym = e == "error" and " "
				or (e == "warning" and " " or "" )
			s = s .. n .. sym
		end
		return s
	end,
		offsets = {{filetype = "NvimTree", text = "File Explorer" }},
}
}

EOF

nnoremap <silent><A-1> <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><A-2> <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><A-3> <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><A-4> <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><A-5> <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><A-6> <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><A-7> <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><A-8> <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><A-9> <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent><A-c> <Cmd>BufferLinePickClose<CR>
nnoremap <silent><A-.> <Cmd>BufferLineCycleNext<CR>
nnoremap <silent><A-,> <Cmd>BufferLineCyclePrev<CR>

