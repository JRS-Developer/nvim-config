lua << EOF
local lspsaga = require 'lspsaga'

lspsaga.setup()


EOF

" lsp provider to find the cursor word definition and reference
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
" code action
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
" show hover doc
nnoremap <silent>K :Lspsaga hover_doc<CR>
" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" show signature help
nnoremap <silent> gs :Lspsaga signature_help<CR>
" rename
nnoremap <silent>gr :Lspsaga rename<CR>
" jump diagnostic
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

