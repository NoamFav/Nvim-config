return {
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			local highlight = {
				"Whitespace", -- Use Whitespace to make it subtle
			}
			require("ibl").setup({
				indent = {
					highlight = highlight,
					char = "│", -- Use a thin vertical bar or another subtle character
				},
				whitespace = {
					highlight = highlight,
					remove_blankline_trail = false,
				},
				scope = {
					enabled = false,
				},
				exclude = {
					filetypes = { "dashboard", "NvimTree", "alpha" }, -- Add filetypes where you don't want indent guides
				},
			})
		end,
	},
}
