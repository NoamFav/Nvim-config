local autocmd = vim.api.nvim_create_autocmd

-- Filetype detection
vim.filetype.add({ extension = { ino = "arduino" } })
vim.filetype.add({ extension = { m = "matlab" } })

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.ttl",
	callback = function()
		vim.bo.filetype = "turtle"
	end,
})

-- Highlight on yank
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Auto format on save
autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		if vim.fn.exists(":FormatWrite") == 2 then
			vim.cmd("silent! FormatWrite")
		end
	end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})
