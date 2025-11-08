-- lua/plugins/trouble.lua
return {
	"folke/trouble.nvim",
	cmd = "Trouble",

	opts = {
		position = "right",
		width = 40,

		icons = {
			error = "",
			warning = "",
			hint = "",
			information = "",
		},

		-- keep panes even if empty + keep updating
		auto_close = false,
		auto_open = false,
		open_no_results = true,
		auto_refresh = true,
		follow = true,

		use_diagnostic_signs = true,

		action_keys = {
			close = "q",
			cancel = "<esc>",
			refresh = "r",
			jump = { "<cr>", "<tab>" },
		},

		fold_open = "",
		fold_closed = "",
		indent_lines = false,
		auto_preview = false,

		signs = {
			error = "",
			warning = "",
			hint = "",
			information = "",
		},
	},

	keys = {
		-- Diagnostics
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics new=true focus=false follow=true pinned=true win.type=split win.relative=win win.position=bottom win.size=12<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },

		-- RIGHT COLUMN STACK (cs on top, cl below)
		-- 1) create the right column & PIN it so we can stack relative to it
		{
			"<leader>cs",
			-- right split, pinned = anchor
			"<cmd>Trouble symbols open focus=false follow=true pinned=true win.type=split win.position=right win.size=40<cr>",
			desc = "Symbols (Trouble) right/top",
		},
		-- 2) open another Trouble view NEW, relative to the pinned window, at the BOTTOM
		{
			"<leader>cl",
			"<cmd>Trouble lsp open new=true focus=false follow=true pinned=true win.type=split win.relative=win win.position=bottom win.size=12<cr>",
			desc = "LSP (Trouble) right/bottom",
		},

		-- Other lists
		{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	},
}
