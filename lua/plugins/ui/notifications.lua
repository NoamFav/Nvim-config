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
		stages = "slide",
		timeout = 2500,
		top_down = true,
		fps = 60,
		render = "compact",
		max_width = function()
			return math.floor(vim.o.columns * 0.38)
		end,
		max_height = function()
			return math.floor(vim.o.lines * 0.28)
		end,
		background_colour = "NONE",
		on_open = function(win)
			vim.api.nvim_win_set_option(win, "winblend", 0)
		end,
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
