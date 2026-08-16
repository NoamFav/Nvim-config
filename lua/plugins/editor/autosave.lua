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
			filename_is_not = {}, -- empty on purpose, nothing's exempt
			filetype_is_not = {},
			modifiable = true,
		},

			-- Prevent autosave on undo/redo operations
			condition = function()
				-- Get the undo tree state
				local undo_state = vim.fn.undotree()
				local seq_cur = undo_state.seq_cur

				-- Store the last sequence number we saw
				if not vim.g.auto_save_last_seq then
					vim.g.auto_save_last_seq = seq_cur
					return true
				end

				-- If seq_cur decreased, it means undo was pressed
				if seq_cur < vim.g.auto_save_last_seq then
					vim.g.auto_save_last_seq = seq_cur
					return false  -- Skip autosave on undo
				end

				vim.g.auto_save_last_seq = seq_cur
				return true
			end,
		write_all_buffers = false,
		-- this is why core/norminette.lua debounces its own runs by 400ms —
		-- this fires way more often than a person actually hits :w
		debounce_delay = 500,
	},
}
