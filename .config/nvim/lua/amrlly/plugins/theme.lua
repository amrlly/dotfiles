return {
	"gbprod/nord.nvim",
	lazy = false,
	priority = 100,
	config = function()
		require("nord").setup({
			transparent = true,
			terminal_colors = true,
			diff = { mode = "bg" },
			borders = true,
			errors = { mode = "bg" },
			search = { theme = "vim" },
		})

		vim.cmd.colorscheme("nord")
	end,
}
