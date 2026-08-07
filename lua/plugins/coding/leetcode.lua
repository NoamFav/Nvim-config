local leet_arg = "leetcode"

return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	-- only loads eagerly when nvim was actually opened with `nvim leetcode`,
	-- lazy everywhere else so it's not dead weight on every startup
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
		-- the build tag here is what lsp/servers.lua's gopls standaloneTags is watching for
		before = { "//go:build leetcode", "", "package main" },
		storage = {
			home = vim.fn.stdpath("data") .. "/leetcode",
		},
	},
}
