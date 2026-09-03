return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "MunifTanjim/nui.nvim" },
	config = function()
		require("xcodebuild").setup({})
		vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>")
		vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>")
		vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>")
		vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>")
	end,
}
