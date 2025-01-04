return {
	"3rd/image.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("image").setup({
			backend = "kitty", -- iTerm2 uses the same protocol as Kitty
			max_width = 50,
			max_height = 30,
			-- Additional configuration options
		})
	end,
}
