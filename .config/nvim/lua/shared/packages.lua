local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable' })
end
vim.opt.rtp:prepend(lazypath)

local packages = {
	{
		'gbprod/nord.nvim',
		lazy = false,
		priority = 100,
		opts = {
			transparent = true,
			terminal_colors = true,
			diff = { mode = "bg" },
			borders = true,
			errors = { mode = "bg" },
			search = { theme = "vim" },
		},
		config = function(_, opts)
			require('nord').setup(opts)
			vim.cmd.colorscheme('nord')
		end
	},

	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				icons_enabled = false,
				theme = 'auto',
				component_separators = '|',
				section_separators = '',
			},
		},
	},
} 

local options = {
	install = {
		colorscheme = { 'nord' }
	}
}

-- Packages
require('lazy').setup(packages, options)
