return {
	"NvChad/nvim-colorizer.lua",
	event = "BufReadPost",
	-- names off: don't need "red" highlighted every time the word shows up in a comment
	opts = { user_default_options = { tailwind = true, names = false } },
}
