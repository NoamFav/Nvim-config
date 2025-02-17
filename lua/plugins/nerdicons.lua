return {
	"glepnir/nerdicons.nvim",
	cmd = "NerdIcons",
	config = function()
		require("nerdicons").setup({
			border = "single", -- Border
			prompt = "󰨭 ", -- Prompt Icon
			preview_prompt = " ", -- Preview Prompt Icon
			width = 0.5, -- float window width
			down = "<Tab>", -- Move down in preview
			up = "<S-Tab>", -- Move up in preview
			copy = "<C-y>", -- Copy to the clipboard
			register = "*", -- Register to copy to
		})
	end,
}
