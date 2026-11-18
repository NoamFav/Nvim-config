return {
	{
		"Diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = { "<F1>" }, -- just a lazy-load trigger, default_map below does the actual binding
		opts = {
			default_map = true,
			auto_update = true,
			user = vim.g.user,
			mail = vim.g.mail,
		},
		config = function(_, opts)
			require("42header").setup(opts)
		end,
	},
}
