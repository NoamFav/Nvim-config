return {
	{
		"Diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = { "<F1>" },
		opts = {
			default_map = true,
			auto_update = true,
			-- Auto-detect from the environment so the header carries *your* login,
			-- not the config author's. On a 42 machine $USER is your intra login.
			-- Override by exporting USER42 / MAIL42, or by setting vim.g.user42 /
			-- vim.g.mail42 in a local file (see core/options.lua).
			user = vim.g.user42,
			mail = vim.g.mail42,
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
