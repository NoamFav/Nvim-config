-- Sticky header pinned to the top of the window showing the enclosing
-- function / loop / if while you scroll a long C function.
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{
			"<leader>uk",
			function()
				require("treesitter-context").toggle()
			end,
			desc = "Toggle context header",
		},
	},
	opts = {
		max_lines = 4, -- cap how tall the context stack gets
		multiline_threshold = 1, -- collapse multi-line signatures to one line
		trim_scope = "outer",
		mode = "cursor", -- context follows the cursor's scope
		separator = "─", -- thin underline beneath the context
		zindex = 20,
	},
	config = function(_, opts)
		require("treesitter-context").setup(opts)
	end,
}
