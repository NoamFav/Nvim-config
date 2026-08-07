local function tune_semantic_tokens()
	local function based_on(group, base, extra)
		local base_hl = vim.api.nvim_get_hl(0, { name = base, link = false })
		vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", base_hl, extra or {}))
	end

	based_on("@lsp.typemod.variable.readonly", "@constant", { italic = true })
	based_on("@lsp.type.macro", "@constant.macro", { bold = true })
	based_on("@lsp.typemod.function.defaultLibrary", "@function.builtin", { italic = true })
	vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
end

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

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					if ft == "c" or ft == "cpp" or ft == "objc" or ft == "objcpp" then
						pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
					end
				end,
			})

			tune_semantic_tokens()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = tune_semantic_tokens,
			})
		end,
	},

	{
		"m-demare/hlargs.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			color = "#e0af68", -- tokyonight-ish amber; distinct from vars/globals
			excluded_filetypes = { "markdown", "text", "help", "sh", "bash", "make" },
		},
	},
}
