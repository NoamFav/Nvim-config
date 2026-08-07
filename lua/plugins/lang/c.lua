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
			-- these came in empty and I never noticed until just now, AST
			-- view works fine without them so leaving it alone for today
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
		-- inlay hints have to be turned on by hand per buffer, clangd doesn't do it for you
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

			-- half of this overlaps core/semantic_tokens.lua, kept local
			-- because it only matters once clangd_extensions is actually loaded
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
