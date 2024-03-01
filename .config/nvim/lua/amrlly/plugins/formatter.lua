return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
		})

		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({ lsp_fallback = true })
		end)

		vim.keymap.set({ "n", "v" }, "<leader>F", function()
			conform.format({ lsp_fallback = true })
			vim.cmd("write")
		end)
	end,
}
