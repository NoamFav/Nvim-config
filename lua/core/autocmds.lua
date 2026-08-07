local autocmd = vim.api.nvim_create_autocmd

-- neovim has never heard of .ino or .m, treats them as nothing in particular
vim.filetype.add({ extension = { ino = "arduino" } })
vim.filetype.add({ extension = { m = "matlab" } })

-- .ttl is RDF Turtle, not a C++ joke, before it gets lumped in with plaintext
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.ttl",
	callback = function()
		vim.bo.filetype = "turtle"
	end,
})

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- guarded: fires on every save regardless of filetype, and formatter.nvim
-- doesn't always register :FormatWrite, so check first or eat an error each time
autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		if vim.fn.exists(":FormatWrite") == 2 then
			vim.cmd("silent! FormatWrite")
		end
	end,
})

-- norminette will fail you over a trailing space you'll never see in the diff
autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- norminette wants real tabs, not four spaces cosplaying as one, and make
-- just breaks silently on spaces instead of complaining about it
autocmd("FileType", {
	pattern = { "c", "h", "cpp", "hpp", "make" },
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

autocmd("FileType", {
	pattern = { "sh", "bash" },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})
