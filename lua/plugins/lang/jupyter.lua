return {
	{
		"3rd/image.nvim",
		opts = { backend = "kitty" }, -- needs the kitty graphics protocol, won't render elsewhere
	},
	{
		"benlubas/molten-nvim",
		build = ":UpdateRemotePlugins",
		ft = { "python", "jupyter" },
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_virt_text_output = true
			-- I'll open the output myself when I want it, not on every cell run
			vim.g.molten_auto_open_output = false
		end,
	},
}
