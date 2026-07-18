-- Window navigation/resizing, tmux/Wezterm-pane aware.
-- Owns <C-h/j/k/l> (moved here from core/keymaps.lua) and adds <A-h/j/k/l> resize.
return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	config = function()
		local ss = require("smart-splits")
		vim.keymap.set("n", "<C-h>", ss.move_cursor_left)
		vim.keymap.set("n", "<C-j>", ss.move_cursor_down)
		vim.keymap.set("n", "<C-k>", ss.move_cursor_up)
		vim.keymap.set("n", "<C-l>", ss.move_cursor_right)
		vim.keymap.set("n", "<A-h>", ss.resize_left)
		vim.keymap.set("n", "<A-j>", ss.resize_down)
		vim.keymap.set("n", "<A-k>", ss.resize_up)
		vim.keymap.set("n", "<A-l>", ss.resize_right)
	end,
}
