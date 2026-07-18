-- Async build/task runner; auto-detects Makefiles so libft-style `make`
-- targets show up as runnable tasks with async output.
return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerRun", "OverseerToggle" },
	keys = {
		{ "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run task" },
		{ "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
	},
	opts = {
		-- No component here ever opens a window (the "open_output" component,
		-- which would, is deliberately left out) — the task list only appears
		-- via the <leader>rt keymap. Completion is reported through
		-- on_complete_notify (vim.notify, routed through fidget.nvim).
		component_aliases = {
			default = {
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},
	},
}
