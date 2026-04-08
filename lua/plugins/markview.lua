return {
	"OXY2DEV/markview.nvim",
	lazy = false,

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("markview").setup({
			preview = { enable = false },
		})
		vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggles previews globally" })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>s",
			"<CMD>Markview splitToggle<CR>",
			{ desc = "Toggles `splitview` for current buffer." }
		)
	end,
}
