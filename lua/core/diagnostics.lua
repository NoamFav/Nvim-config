vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	severity_sort = true,
	signs = true,
	underline = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Diagnostic signs
local signs = {
	Error = "",
	Warn = "",
	Hint = "", -- or "" if your font supports it
	Info = "",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
