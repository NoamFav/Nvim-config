return {
	{
		"Diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = { "<F1>" },
		opts = {
			default_map = true,
			auto_update = true,
			user = "nfavier",
			mail = "nfavier@student.42.fr",
		},
		config = function(_, opts)
			require("42header").setup(opts)
		end,
	},
	-- NOTE: norminette42.nvim was removed — it ran `norminette` synchronously on
	-- the UI thread (BufEnter + every save) and hard-froze Neovim when norminette
	-- was slow/hung. Diagnostics are now provided asynchronously by
	-- lua/core/norminette.lua (wired up in init.lua).
}
