require('material').setup({	
	constrast = true,
	borders = false,
	text_contrast = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = true -- Enable higher contrast text for darker style
	},
})
vim.g.material_style = "deep ocean"

vim.cmd 'colorscheme material'
