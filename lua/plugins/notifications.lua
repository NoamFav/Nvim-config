return {
	"rcarriga/nvim-notify",
	lazy = false,
	priority = 1000,
	---@type notify.Config
	opts = {
		stages = "fade_in_slide_out", -- Animation style for notifications
		timeout = 3000, -- Duration notifications are visible in milliseconds
		background_colour = "#000000", -- Background color for notifications
		fps = 30, -- Frame rate for animations
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
		vim.notify = notify -- Override vim.notify to use nvim-notify by default
	end,
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
}
