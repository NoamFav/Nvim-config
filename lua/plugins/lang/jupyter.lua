return {
	{
		"3rd/image.nvim",
		opts = { backend = "kitty" },
	},
	{
		"benlubas/molten-nvim",
		build = ":UpdateRemotePlugins",
		ft = { "python", "jupyter" },
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_virt_text_output = true
			vim.g.molten_auto_open_output = false
		end,
	},
}
