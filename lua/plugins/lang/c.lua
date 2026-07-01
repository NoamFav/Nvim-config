-- C / C++ readability layer.
--   * clangd_extensions — inlay hints (param names, types) + AST view
--   * hlargs            — function parameters get one distinct colour everywhere
--
-- Cross-language semantic-token styling (const/macros/stdlib/mutable/…) lives in
-- lua/core/semantic_tokens.lua and covers C/C++ too, so it isn't repeated here.
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

			-- Turn on inlay hints for C-family buffers
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

	{
		"m-demare/hlargs.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			-- hlargs' priority (10000) already beats LSP semantic tokens, so
			-- parameters keep this colour consistently across every language it
			-- supports (C/C++, Go, Rust, Lua, Python, JS/TS, Java, …).
			color = "#e0af68", -- tokyonight-ish amber; distinct from vars/globals
			excluded_filetypes = { "markdown", "text", "help", "sh", "bash", "make" },
		},
	},
}
