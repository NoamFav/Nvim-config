return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	-- snacks dashboard's default "Restore Session" button only shows up once it detects
	-- a session plugin like this one -- no extra wiring needed there
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore Session",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore Last Session",
		},
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't Save Current Session",
		},
	},
}
