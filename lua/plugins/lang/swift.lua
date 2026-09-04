return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "MunifTanjim/nui.nvim" },
	cmd = { "XcodebuildSetup", "XcodebuildPicker", "XcodebuildBuildRun", "XcodebuildTest" },
	keys = {
		{ "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & run" },
		{ "<leader>xt", "<cmd>XcodebuildTest<cr>", desc = "Run tests" },
		{ "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select device" },
		{ "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle logs" },
	},
	config = function()
		require("xcodebuild").setup({})
	end,
}
