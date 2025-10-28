return {
	"Pocco81/auto-save.nvim",
	event = { "InsertLeave", "TextChanged" },
	opts = {
		enabled = true,
		execution_message = {
			message = function()
				return "  AutoSave: saved at fucking " .. vim.fn.strftime("%H:%M:%S")
			end,
			dim = 0.18,
			cleaning_interval = 250,
		},
		events = { "BufLeave" },
		conditions = {
			exists = true,
			filename_is_not = {},
			filetype_is_not = {},
			modifiable = true,
		},
		write_all_buffers = false,
		debounce_delay = 135,
	},
}
