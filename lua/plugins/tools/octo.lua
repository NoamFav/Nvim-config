return {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	cmd = "Octo",
	keys = {
		{ "<leader>op", "<cmd>Octo pr list<cr>", desc = "PR list" },
		{ "<leader>or", "<cmd>Octo review start<cr>", desc = "Start review" },
	},
	opts = { enable_builtin = true },
}
