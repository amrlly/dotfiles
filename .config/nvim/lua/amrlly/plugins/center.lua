return {
	'shortcuts/no-neck-pain.nvim',
	config = function()
		require('no-neck-pain').setup({
			width = 140,
			mappings = {
				enabled = true,
				toggle = '<Leader>np',
				toggleLeftSide = '<Leader>nql',
				toggleRightSide = '<Leader>nqr',
				widthUp = '<Leader>n=',
				widthDown = '<Leader>n-',
			},
		})
	end
}
