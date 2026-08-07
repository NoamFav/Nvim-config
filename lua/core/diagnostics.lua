vim.diagnostic.config({
	virtual_text = true,
	-- yes it jitters while you type, no I'm not turning it off, I'd rather
	-- know the line is broken now than find out on save
	update_in_insert = true,
	severity_sort = true,
	underline = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
		priority = 10,
	},
})
