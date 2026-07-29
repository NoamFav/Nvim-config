local leet_arg = "leetcode"

return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	lazy = leet_arg ~= vim.fn.argv()[1],
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		arg = leet_arg,
		lang = "golang",
		before = { "//go:build leetcode", "", "package main" },
		storage = {
			home = vim.fn.stdpath("data") .. "/leetcode",
		},
	},
}
