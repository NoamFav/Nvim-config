return {
	"rcarriga/nvim-notify",
	lazy = false,
	priority = 1000,
	keys = {
		{
			"<leader>ni",
			function()
				vim.notify("Hello, Info!", "info")
			end,
			desc = "Notify Info",
		},
		{
			"<leader>nw",
			function()
				vim.notify("Warning Message!", "warn")
			end,
			desc = "Notify Warning",
		},
		{
			"<leader>ne",
			function()
				vim.notify("Error Occurred!", "error")
			end,
			desc = "Notify Error",
		},
	},
	opts = {
		stages = "fade_in_slide_out",
		timeout = 3000,
		background_colour = "#000000",
		fps = 30,
		icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "✎",
		},
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
