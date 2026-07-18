-- Async build/task runner. Picks up Makefiles automatically.
return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerRun", "OverseerToggle" },
	keys = {
		{ "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run task" },
		{ "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
	},
	opts = {
		-- Keep the default components notify-only (skip open_output) so
		-- nothing pops a window on its own — <leader>rt is the only way in.
		component_aliases = {
			default = {
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},
	},
}
