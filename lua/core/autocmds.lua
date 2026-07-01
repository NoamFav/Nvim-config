local autocmd = vim.api.nvim_create_autocmd

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

-- C / H: real tabs, 4 wide (the Norm)
autocmd("FileType", {
	pattern = { "c", "h", "cpp", "hpp" },
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

-- Makefiles: tabs are mandatory, never expand them
autocmd("FileType", {
	pattern = "make",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

-- Shell scripts: 4-space indent
autocmd("FileType", {
	pattern = { "sh", "bash" },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})
