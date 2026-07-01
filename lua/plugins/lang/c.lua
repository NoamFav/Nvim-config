-- C / C++ polish. clangd is configured natively in lua/lsp/servers.lua; this
-- just layers on the nice-to-look-at extras (inlay hints, AST view, memory
-- usage / type hierarchy) that match the rest of the rounded-border UI.
return {
	{
		"p00f/clangd_extensions.nvim",
		ft = { "c", "cpp", "objc", "objcpp" },
		opts = {
			inlay_hints = {
				inline = true,
				only_current_line = false,
				show_parameter_hints = true,
				parameter_hints_prefix = "<- ",
				other_hints_prefix = "=> ",
			},
			ast = {
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					statement = ";",
					specifier = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
		config = function(_, opts)
			require("clangd_extensions").setup(opts)
			-- Toggle inlay hints on for C-family buffers
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					if ft == "c" or ft == "cpp" or ft == "objc" or ft == "objcpp" then
						pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
					end
				end,
			})
		end,
	},
}
